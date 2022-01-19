import { buildings } from "../OutdoorMap/geometry";
import { standardZoomLevel, indoorZoomLevel, styleMap, EntranceStyle, PoIStyle, IndoorStyle } from "../constants";

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

mymap.createPane('buildings');

// buildings includes all geometry-data extracted from OSM, see campus.js
// layers has the "feature" property as index, e.g. "Studentendorf Stahnsdorfer Straße"
for (const feature of buildings) {
  // If the current campus (=group of buildings) is unknown, create a layergroup for it
  if (!layers[feature.properties.campus]) {
    layers[feature.properties.campus] = L.layerGroup().addTo(mymap);
  }

  // Determine Style (highlighting-colour) dependent of group
  let layerStyle = styleMap[feature.properties.campus] ?? styleMap["default"];

  // Add the building as a layer
  const layer = L.geoJSON(feature, { style: layerStyle, pane: 'buildings' });
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
  console.log(feature.type);
  switch (feature.properties.type) {
    case "Entrance":
      console.log("here");
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

        if (layer.options.pane === 'buildings') {
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

        if (layer.options.pane === 'buildings') {
          layer.openTooltip(tooltip);

          layer.setStyle({
            ...layer.options.style,
            fillOpacity: 0.65,
          });
        } else {
          layer.closeTooltip(tooltip);

          layer.setStyle({
            ...IndoorStyle,
            color: 'rgba(0, 0, 0, 0)',
          });
        }
      }
    });
  }
  lastZoom = zoom;
});

L.control.layers(null, layers).addTo(mymap);

console.log("[MAP] Layers built");

window.positions = []

// TomTom Routing API-key: peRlaISfnHGUKWZpRw4O11yc3B4Ay2t5
// mapbox API key sk.eyJ1IjoicHZpaSIsImEiOiJja3g1MnhkdGQxMTlzMm5xa3FpNzlrcHYxIn0.ZX0lMZW2IofVpmIJQtHUmA

// mapbox token

console.log(window.location.host + '/directions')

// routingControl does everything related to navigation
window.routingControl = L.Routing.control({
  // the router is responsible for calculating the route
  router: new Router(
    {
      serviceUrl: window.location.origin + '/directions',
      useHints: false,
      profile: 'walking',
      routingOptions: {
        'walkway_bias': 1,
        'walking_speed': 5
      },
    }
  ),
  // the plan is the window on the right-hand side of the map with the search-bar, stop-button and overview and steps of the current navigation 
  plan: L.Routing.plan(positions, {
    createMarker: function (i, wp) {
      return L.marker(wp.latLng, {
        draggable: true,
        icon: L.icon.glyph({ glyph: String.fromCharCode(65 + i) })
      });
    },
    geocoder: L.Control.Geocoder.nominatim()
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
  .on('routingstart', (e) => {
    document.getElementById('StopNavigation').style.display = 'block';
    document.getElementById('mobile-view-welcome-routing-text').style.display = 'none';
  })
  .on('waypointschanged', (e) => {
    // this handler is called whenever the waypoints are changed in any way (search bar or clicking in the map)
    var waypoints = routingControl.getWaypoints()
    positions = []
    // waypoints[0].latLng and [1].latLng are not null if they were set by the user 
    if (waypoints[0].latLng != null)
      positions.push(waypoints[0].latLng)
    if (waypoints[1].latLng != null)
      positions.push(waypoints[1].latLng)
    // if we have both a start and endpoint, we show the routingControl
    if (positions.length === 2)
      routingControl.show()
    // always calculate the route to show the 'A' marker if only one waypoint is set
    routingControl.route()
  });

var routingControlContainer = routingControl.getContainer();
var controlContainerParent = routingControlContainer.parentNode;
var controlDiv = document.getElementById("routing-control");
var stopDiv = document.getElementById("routing-stop-button");

function moveRoutingStopButton() {
  var stopButton = document.getElementById("StopNavigation");
  if (stopButton) {
    var stopButtonParent = document.getElementsByClassName("leaflet-routing-geocoder-stop")[0];
    if (window.screen.width < 640) {
      if (stopButtonParent.contains(stopButton)) {
        stopButtonParent.removeChild(stopButton);
        stopDiv.appendChild(stopButton);
      }
    } else {
      if (stopDiv.querySelector('#StopNavigation')) {
        stopDiv.removeChild(stopButton);
        stopButtonParent.appendChild(stopButton);
      }
    }
  }
}

function moveRoutingControl() {
  if (window.screen.width < 640) {
    if (controlContainerParent.contains(routingControlContainer)) {
      controlContainerParent.removeChild(routingControlContainer);
      controlDiv.appendChild(routingControlContainer);
    }
  } else {
    // der Wert ist irgendwie noch hard gecoded
    if (controlDiv.querySelector('.leaflet-routing-container')) {
      controlDiv.removeChild(routingControlContainer);
      controlContainerParent.appendChild(routingControlContainer);
    }
  }
}

window.addEventListener("load", moveRoutingControl);
window.addEventListener("load", moveRoutingStopButton);
window.addEventListener("resize", moveRoutingControl);
window.addEventListener("resize", moveRoutingStopButton);

function onMapClick(e) {
  var pos = e.latlng
  positions.push(pos)
  // by inserting a third waypoint, the very first inserted waypoint won't be considered for the route anymore
  if (positions.length === 3) {
    positions.shift()
  }
  // all the calculations will be done within the 'waypointschanged' handler of the routingControl
  routingControl.setWaypoints(positions)
}

// Build the stop buton and insert it into the routingControl-plan
(function buildStopButton() {
  const el = document.createElement('div')
  el.className = 'leaflet-routing-geocoder-stop';
  el.innerHTML = `
    <input 
        type="button" 
        id="StopNavigation" 
        value="Stop" 
        onclick="
            event.stopPropagation();
            document.getElementById('StopNavigation').style.display = 'none';
            document.querySelector('#mobile-view-welcome-routing-text').style.display = 'block';
            positions = []
            routingControl.hide()
            routingControl.setWaypoints(positions).route()" 
        class="stop-button" 
        style="
            width: 100px; 
            font-size: 1.75vh;
            background-color: red;
            color: white"
    />`
  // Do not render the '+' button that can be used to add waypoints
  document.querySelector('.leaflet-routing-add-waypoint').style.display = 'none'
  // Add our Stop button to the routingControl-plan
  document.querySelector('.leaflet-routing-geocoders').appendChild(el)
})()

mymap.on('click', onMapClick);


function onLocationFound(e) {
  routingControl.setWaypoints([e.latlng, L.latLng(coordinates[0].lat, coordinates[0].lng)]);
}

if(coordinates != null){
  mymap.on('locationfound', onLocationFound);
  lc.start();
}
// Per default, we don't want the stop button to be shown, as there is no route
document.getElementById('StopNavigation').style.display = 'none';
