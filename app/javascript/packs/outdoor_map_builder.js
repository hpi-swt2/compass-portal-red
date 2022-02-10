import {
  EntranceStyle,
  IndoorStyle,
  indoorZoomLevel,
  PoIStyle,
  standardZoomLevel,
  styleMap,
  redMarkerIcon
} from "../constants";
import { buildings } from "../OutdoorMap/geometry";
import { showRoomPopup } from "./indoor_map_builder";

function buildSearchResultMarkers() {
  if (layers["Search Results"]) {
    layers["Search Results"].clearLayers();
  }
  layers["Search Results"] = L.layerGroup().addTo(mymap);
  for (const result of window.searchResults) {
    const layer = L.geoJSON(result.geoJson);
    const center = layer.getBounds().getCenter();

    const marker = L.marker(center, { icon: redMarkerIcon });
    marker.addEventListener('click',  (event) =>  {
      showRoomPopup(result.id)
    });
    layers["Search Results"].addLayer(marker);
  }
  if (window.searchResults?.length) {
    const searchResultsMarkers = L.featureGroup(layers["Search Results"].getLayers());
    mymap.fitBounds(searchResultsMarkers.getBounds().pad(0.5));
  }
}

if (window.searchResults?.length) {
  const searchResultsMarkers = L.featureGroup(layers["Search Results"].getLayers());
  mymap.fitBounds(searchResultsMarkers.getBounds().pad(0.5));
}
}

var pointInPolygon = require("point-in-polygon");

console.log("[MAP] Pre map init");

// If the map object still exists, initiate a new one
// (relevant, when the user navigates back and the old page is cached)
if (window.mymap) window.mymap.remove();

// Set the leaflet map with center and zoom-level
window.mymap = L.map("map").setView([52.393, 13.129], standardZoomLevel);

console.log("[MAP] Map init done");

// Tileserver to be used as background
L.tileLayer(
  // there is a "dark-mode" available for this tile-layer:
  // "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png"
  "https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png",
  {
    minZoom: 1,
    // this maxZoom is the maximum for the given tileLayer. You CAN increase the number
    // which will still render the building-polygons etc. defined by us, but
    // no longer render the tile-background layer
    // We could think of doing that if we need more zoom for the indoor-maps, it shouldn't look too bad
    maxZoom: 20,
    attribution:
      '&copy; <a href="https://stadiamaps.com/">Stadia Maps</a>, &copy; <a href="https://openmaptiles.org/">OpenMapTiles</a> &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors | Schnavigator',
  }
).addTo(mymap);

console.log("[MAP] Tile layer done");

var lc = L.control
  .locate({
    locateOptions: {
      watch: true,
      enableHighAccuracy: true,
    },
  })
  .addTo(mymap);

window.layers = {};

mymap.createPane("buildings");

let campusNames = [];

// buildings includes all geometry-data extracted from OSM, see campus.js
// layers has the "feature" property as index, e.g. "Studentendorf Stahnsdorfer Straße"
for (const feature of buildings) {
  // If the current campus (=group of buildings) is unknown, create a layergroup for it
  if (!layers[feature.properties.campus]) {
    layers[feature.properties.campus] = L.layerGroup().addTo(mymap);
    campusNames.push(feature.properties.campus);
  }

  // Determine Style (highlighting-colour) dependent of group
  let layerStyle = styleMap[feature.properties.campus] ?? styleMap["default"];

  // Add the building as a layer
  const layer = L.geoJSON(feature, { style: layerStyle, pane: "buildings" });
  // Add a tooltip displaying the name of the building, taken from the GeoJSON
  layer.bindTooltip(feature.properties.name, {
    permanent: true,
    className: "marker_label",
    offset: feature.properties.offset,
    direction: "right",
  });
  // Add the building to its campus layergroup
  layers[feature.properties.campus].addLayer(layer);
}

layers["Points of Interest"] = L.layerGroup().addTo(mymap);
for (const feature of points_of_interest) {
  let layerStyle;
  switch (feature.properties.type) {
    case "Entrance":
      layerStyle = EntranceStyle;
      break;
    default:
      layerStyle = PoIStyle;
  }
  const layer = L.geoJSON(feature);
  layer.bindTooltip(feature.properties.name, {
    permanent: true,
    className: "marker_label",
    offset: [-14, 0],
    direction: "right",
  });
  layer.bindPopup(feature.properties.description);
  layers["Points of Interest"].addLayer(layer);
}

buildSearchResultMarkers()

// make names disappear when zoomed out
var lastZoom;
mymap.on("zoomend", function () {
  var zoom = mymap.getZoom();
  if (
    (zoom < standardZoomLevel || zoom > indoorZoomLevel) &&
    (!lastZoom || lastZoom >= standardZoomLevel || lastZoom <= indoorZoomLevel)
  ) {
    mymap.removeLayer(layers["Points of Interest"]);
    mymap.eachLayer(function (layer) {
      if (layer.getTooltip()) {
        const tooltip = layer.getTooltip();

        if (layer.options.pane === "buildings") {
          layer.closeTooltip(tooltip);

          if (zoom > indoorZoomLevel) {
            layer.setStyle({
              ...layer.options.style,
              fillOpacity: 0.0,
            });
          }
        } else if (zoom > indoorZoomLevel) {
          layer.openTooltip(tooltip);
          layer.setStyle(IndoorStyle);
        }
      }
    });
  } else if (
    zoom >= standardZoomLevel &&
    zoom <= indoorZoomLevel &&
    (!lastZoom || lastZoom < standardZoomLevel || lastZoom > indoorZoomLevel)
  ) {
    mymap.addLayer(layers["Points of Interest"]);
    mymap.eachLayer(function (layer) {
      if (layer.getTooltip()) {
        const tooltip = layer.getTooltip();

        if (layer.options.pane === "buildings") {
          layer.openTooltip(tooltip);

          layer.setStyle({
            ...layer.options.style,
          });
        } else {
          layer.closeTooltip(tooltip);
          layer.setStyle({
            ...IndoorStyle,
            color: "rgba(0,0,0,0)",
          });
        }
      }
    });
  }
  lastZoom = zoom;
  setStyleForHighlightedBuilding();
});

L.control.layers(null, layers).addTo(mymap);

console.log("[MAP] Layers built");

function allBuildings() {
  var results = []
  for (const campus of campusNames) {
    let buildingsOfCampus = layers[campus];
    results.push(...buildingsOfCampus.getLayers())
  }
  return results
}

function buildingsByQuery(query) {
  return allBuildings().filter((buildingLayer) => {
    // The HPIGeocoder and the highlighting of buildings rely on this fact, which happens to always be the case.
    // Please inform someone if this warning occurs :)
    if(buildingLayer.getLayers().length > 1){
      console.log("WARNING: Not only one inner building layer in:", buildingLayer);
    }
    const innerBuildingLayer = buildingLayer.getLayers()[0];
    const buildingInfo = innerBuildingLayer.feature;
    return buildingInfo.properties.name && buildingInfo.properties.name.toLowerCase().indexOf(query.toLowerCase()) > -1;
  })
}

function buildingAtLocation(location) {
  // different representation of the position for the pointInPolygon-method
  const locationArray = [location.lng, location.lat]
  for(const buildingLayer of allBuildings()) {
    const innerBuildingLayer = buildingLayer.getLayers()[0];
    const buildingInfo = innerBuildingLayer.feature
    const polygonCoordinates = buildingInfo.geometry.coordinates[0];
    if(pointInPolygon(locationArray, polygonCoordinates)) return buildingLayer
    // The next line ensures that the buildings are highlighted and properly geocoded,
    // when they are being routed to. This is because we route to the center of the building.
    if(innerBuildingLayer.getCenter().toBounds(1).contains(location)) return buildingLayer
  }
  return undefined
}

const originalGeocoder = new L.Control.Geocoder.nominatim()

const HPIGeocoder = {
  getHPISuggestions(query){
    return buildingsByQuery(query).map((buildingLayer) => {
      const innerBuildingLayer = buildingLayer.getLayers()[0];
      const buildingInfo = innerBuildingLayer.feature;
      return {
        name: buildingInfo.properties.name,
        center: innerBuildingLayer.getCenter(),
        bbox: innerBuildingLayer.getBounds()
      }
    });
  },

  buildingInfoAtLocation(location) {
    if(!location) return undefined;
    const buildingLayer = buildingAtLocation(location)
    if(!buildingLayer) return undefined;
    const innerBuildingLayer = buildingLayer.getLayers()[0];
    const buildingInfo = innerBuildingLayer.feature;
    return {
      name: buildingInfo.properties.name,
      center: innerBuildingLayer.getCenter(),
      bbox: innerBuildingLayer.getBounds()
    }
  },

  /**
   * Performs a geocoding query and returns the results to the callback in the provided context
   * @param query the query
   * @param cb the callback function
   * @param context the this context in the callback
   */
  geocode(query, cb, context){
    var that = this;
    // This construction is used to append further suggestions to the ones given by the originalGeocoder
    var callbackProxy = function(originalSuggestions) {
      var hpiSuggestions = that.getHPISuggestions(query);
      cb.call(context, hpiSuggestions.concat(originalSuggestions));
    }
    originalGeocoder.geocode(query, callbackProxy, context);
  },
  
  /**
   * Performs a geocoding query suggestion (this happens while typing) and returns the results to the callback in the provided context
   * @param query the query
   * @param cb the callback function
   * @param context the this context in the callback
   */
  suggest(query, cb, context){
    cb.call(context, this.getHPISuggestions(query));
  },

  /**
   * Performs a reverse geocoding query and returns the results to the callback in the provided context
   * @param location the coordinate to reverse geocode
   * @param scale the map scale possibly used for reverse geocoding
   * @param cb the callback function
   * @param context the this context in the callback
   */
  reverse(location, scale, cb, context){
    const buildingInfo = this.buildingInfoAtLocation(location);
    
    if (buildingInfo){
      cb.call(context, [buildingInfo]);
    } else {
      originalGeocoder.reverse(location, scale, cb, context);
    }
  }
}

console.log(window.location.host + "/directions");

// routingControl does everything related to navigation
window.routingControl = L.Routing.control({
  // the router is responsible for calculating the route
  router: new Router({
    serviceUrl: window.location.origin + "/directions",
    useHints: false,
    profile: "walking",
    routingOptions: {
      walkway_bias: 1,
      walking_speed: 5,
    },
  }),
  // the plan is the window on the right-hand side of the map with the search-bar, stop-button and overview and steps of the current navigation
  plan: L.Routing.plan([], {
    createMarker: function (i, wp) {
      return L.marker(wp.latLng, {
        draggable: true,
        icon: L.icon.glyph({ glyph: String.fromCharCode(65 + i) }),
      });
    },
    geocoder: HPIGeocoder,
  }),
  collapsible: true,
  show: false,
  routeWhileDragging: true,
  autoRoute: false,
  lineOptions: {
    styles: [{ color: 'blue' }]
  }
}).addTo(mymap)
// when routing call happens, there will be the stop button in the navigation plan
.on('routingstart', (e)=>{
  console.log("routing start");
  document.getElementById('StopNavigation').style.display = 'block';
  document.getElementsByClassName('leaflet-routing-alternatives-container')[0].style.display = 'block';
  document.getElementById('mobile-view-welcome-routing-text').style.display = 'none';
  document.getElementsByClassName('leaflet-routing-geocoders')[0].style.width = '50%';
  const roomPopup = document.getElementById('room_popup')
  if (roomPopup) roomPopup.style.display = 'none';
  document.getElementById('map-navigation-popup').style.display = "block"
})
.on('waypointschanged', (e)=>{
  console.log("waypointschanged");
  // this handler is called whenever the waypoints are changed in any way (search bar or clicking in the map)
  changeHighlightedBuilding(routingControl.getWaypoints()[1].latLng);

  routingControl.show()
  // always calculate the route to show the 'A' marker if only one waypoint is set
  
});


let highlightedBuilding = null;

// highlight the building and only show the outline if we are in the "Indoor-Mode"
function setStyleForHighlightedBuilding() {
  if (highlightedBuilding) {
    highlightedBuilding.setStyle(styleMap["HighlightedBuilding"]);
    var zoom = mymap.getZoom();
    if (zoom > indoorZoomLevel) {
      highlightedBuilding.setStyle({
        fillOpacity: 0.0,
      });
    }
  }
}


function changeHighlightedBuilding(position) {
  // reset the style of the previously highlighted building, if available
  // make sure to respect the zoom level and only show the outline if we are in the "Indoor-Mode"
  if (highlightedBuilding) {
    const id = highlightedBuilding._leaflet_id - 1;
    highlightedBuilding.setStyle(
      styleMap[highlightedBuilding._layers[id].feature.properties.campus]
    );
    var zoom = mymap.getZoom();
    if (zoom < standardZoomLevel || zoom > indoorZoomLevel) {
      highlightedBuilding.setStyle({
        fillOpacity: 0.0,
      });
    }
  }
  // reset the highlighted building to be undefined
  highlightedBuilding = null;
  // if no new position was provided, do nothing
  if (!position) {
    return;
  }

  const buildingLayer = buildingAtLocation(position)
  highlightedBuilding = buildingLayer
  setStyleForHighlightedBuilding()
  return;
}

function buildNavigationButton() {
  const el = document.createElement("div");
  el.className =
    "leaflet-navigation-button leaflet-control leaflet-control-layers";
  el.id = "leaflet-navigation-button";
  el.innerHTML = `
    <i 
      class="fa fa-route fa-3x navigation-icon"
      onclick="
        document.getElementById('map-navigation-popup').style.display = 'inline';
        event.stopPropagation();
        document.getElementById('map-popup').style.display = 'none';"
    >
    </i>
  `;
  document.querySelector(".leaflet-right").appendChild(el);
}
buildNavigationButton();

document.getElementsByClassName(
  "leaflet-routing-collapse-btn"
)[0].style.display = "none";

// move rounting container to map-navigation-popup
let element = document.getElementsByClassName("leaflet-routing-container")[0];
let parent = element.parentNode;
let targetDiv = document.getElementById("routing-controller");
targetDiv.appendChild(element);


export function showMarker(position) {
  // .locate() function returns map, so chaining works
  mymap
    .locate()
    .off("locationfound")
    .on("locationfound", function (e) {
      routingControl.setWaypoints([e.latlng, position]);
    })
    .off("locationerror")
    .on("locationerror", function (e) {
      console.log("location error. Use previous start point for navigation");
      const previousStart = routingControl.getWaypoints()[0];
      routingControl.setWaypoints([previousStart, position]);
    });
}
export function startNavigation(){
  routingControl.route()
}

function onMapClick(e) {
  showMarker(e.latlng)
}

// Build the stop buton and insert it into the routingControl-plan
function buildStopButton() {
  const el = document.createElement("div");
  el.className = "leaflet-routing-geocoder-stop";
  el.innerHTML = `
    <input 
        type="button" 
        id="StopNavigation" 
        value="Stop" 
        onclick="
            event.stopPropagation();
            document.getElementById('StopNavigation').style.display = 'none';
            document.querySelector('#mobile-view-welcome-routing-text').style.display = 'block';
            routingControl.hide();
            routingControl.setWaypoints([]).route();
            document.getElementsByClassName('leaflet-routing-alternatives-container')[0].style.display = 'none';
            document.getElementsByClassName('leaflet-routing-geocoders')[0].style.width = '100%';"
        class="stop-button iconbutton" 
        style="border-color: transparent;"
    />`;
  // Do not render the '+' button that can be used to add waypoints
  document.querySelector(".leaflet-routing-add-waypoint").style.display =
    "none";
  // Add our Stop button to the routingControl-plan
  document.querySelector(".leaflet-routing-geocoders").appendChild(el);
}
buildStopButton();

mymap.on("click", onMapClick);

function onLocationFound(e) {
  routingControl.setWaypoints([
    e.latlng,
    L.latLng(coordinates[0].lat, coordinates[0].lng),
  ]);
}

if (coordinates != null) {
  mymap.on("locationfound", onLocationFound);
  lc.start();
}
// Per default, we don't want the stop button to be shown, as there is no route

document.getElementById("StopNavigation").style.display = "none";

window.buildSearchResultMarkers = buildSearchResultMarkers

