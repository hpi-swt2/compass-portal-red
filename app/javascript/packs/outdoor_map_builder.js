import {
  EntranceStyle,
  IndoorStyle,
  indoorZoomLevel,
  PoIStyle,
  standardZoomLevel,
  styleMap,
} from '../constants';
import { buildings } from '../OutdoorMap/geometry';
var pointInPolygon = require('point-in-polygon')

console.log('[MAP] Pre map init');

// If the map object still exists, initiate a new one
// (relevant, when the user navigates back and the old page is cached)
if (window.mymap) window.mymap.remove();

// Set the leaflet map with center and zoom-level
window.mymap = L.map('map').setView([52.393, 13.129], standardZoomLevel);

console.log('[MAP] Map init done');

// Tileserver to be used as background
L.tileLayer(
  // there is a "dark-mode" available for this tile-layer:
  // "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png"
  'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png',
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

console.log('[MAP] Tile layer done');

L.control
  .locate({
    locateOptions: {
      watch: true,
      enableHighAccuracy: true,
    },
  })
  .addTo(mymap);

window.layers = {};

mymap.createPane('buildings');

let campusNames = []

// buildings includes all geometry-data extracted from OSM, see campus.js
// layers has the "feature" property as index, e.g. "Studentendorf Stahnsdorfer Straße"
for (const feature of buildings) {
  // If the current campus (=group of buildings) is unknown, create a layergroup for it
  if (!layers[feature.properties.campus]) {
    layers[feature.properties.campus] = L.layerGroup().addTo(mymap);
      campusNames.push(feature.properties.campus);
  }

  // Determine Style (highlighting-colour) dependent of group
  let layerStyle = styleMap[feature.properties.campus] ?? styleMap['default'];

  // Add the building as a layer
  const layer = L.geoJSON(feature, { style: layerStyle, pane: 'buildings' });
  // Add a tooltip displaying the name of the building, taken from the GeoJSON
  layer.bindTooltip(feature.properties.name, {
    permanent: true,
    className: 'marker_label',
    offset: feature.properties.offset,
    direction: 'right',
  });
  // Add the building to its campus layergroup
  layers[feature.properties.campus].addLayer(layer);
}

layers['Points of Interest'] = L.layerGroup().addTo(mymap);
for (const feature of points_of_interest) {
  let layerStyle;
  switch (feature.properties.type) {
    case 'Entrance':
      layerStyle = EntranceStyle;
      break;
    default:
      layerStyle = PoIStyle;
  }
  const layer = L.geoJSON(feature);
  layer.bindTooltip(feature.properties.name, {
    permanent: true,
    className: 'marker_label',
    offset: [-14, 0],
    direction: 'right',
  });
  layer.bindPopup(feature.properties.description);
  layers['Points of Interest'].addLayer(layer);
}

// make names disappear when zoomed out
var lastZoom;
mymap.on('zoomend', function () {
  var zoom = mymap.getZoom();
  if ((zoom < standardZoomLevel || zoom > indoorZoomLevel) && 
  (!lastZoom || lastZoom >= standardZoomLevel || lastZoom <= indoorZoomLevel)) {
    mymap.removeLayer(layers['Points of Interest']);
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
  } else if (zoom >= standardZoomLevel && zoom <= indoorZoomLevel &&
    (!lastZoom || lastZoom < standardZoomLevel || lastZoom > indoorZoomLevel)) {
    mymap.addLayer(layers['Points of Interest']);
    mymap.eachLayer(function (layer) {
      if (layer.getTooltip()) {
        const tooltip = layer.getTooltip();

        if (layer.options.pane === 'buildings') {
          layer.openTooltip(tooltip);

          layer.setStyle({
            ...layer.options.style,
          });
        } else {
          layer.closeTooltip(tooltip);
          layer.setStyle({
            ...IndoorStyle,
            color: 'rgba(0,0,0,0)',
          });
        }
      }
    });
  }
  lastZoom = zoom;
  setStyleForHighlightedBuilding();
});

L.control.layers(null, layers).addTo(mymap);

console.log('[MAP] Layers built');

// TomTom Routing API-key: peRlaISfnHGUKWZpRw4O11yc3B4Ay2t5
// mapbox API key sk.eyJ1IjoicHZpaSIsImEiOiJja3g1MnhkdGQxMTlzMm5xa3FpNzlrcHYxIn0.ZX0lMZW2IofVpmIJQtHUmA

// mapbox token

console.log(window.location.host + '/directions');

// routingControl does everything related to navigation
window.routingControl = L.Routing.control({
    // the router is responsible for calculating the route
  router: new Router({
    serviceUrl: window.location.origin + '/directions',
    useHints: false,
    profile: 'walking',
    routingOptions: {
      'walkway_bias': 1,
      'walking_speed': 5
    },
  }),
    // the plan is the window on the right-hand side of the map with the search-bar, stop-button and overview and steps of the current navigation 
    plan: L.Routing.plan([], {
        createMarker: function(i, wp) {
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
.on('routingstart', (e)=>{
  console.log("routing start");
  document.getElementById('StopNavigation').style.display = 'block';
  document.getElementsByClassName('leaflet-routing-alternatives-container')[0].style.display = 'block';
  document.getElementById('mobile-view-welcome-routing-text').style.display = 'none';
  document.getElementsByClassName('leaflet-routing-geocoders')[0].style.width = '50%';
  if (document.getElementById('map-popup')) document.getElementById('map-popup').style.display = 'none';
  document.getElementById('map-navigation-popup').style.display = "block"
})
.on('waypointschanged', (e)=>{
  console.log("waypointschanged");
  // we only highlight the destination of the current navigation route
  changeHighlightedBuilding(routingControl.getWaypoints()[1].latLng);
  
  // this handler is called whenever the waypoints are changed in any way (search bar or clicking in the map)
  routingControl.show()
  // always calculate the route to show the 'A' marker if only one waypoint is set
  routingControl.route()
});

let highlightedBuilding = null

// highlight the building and only show the outline if we are in the "Indoor-Mode"
function setStyleForHighlightedBuilding() {
  if(highlightedBuilding) {
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
  if(highlightedBuilding) {
    const id = highlightedBuilding._leaflet_id-1;
    highlightedBuilding.setStyle(styleMap[highlightedBuilding._layers[id].feature.properties.campus]);
    var zoom = mymap.getZoom();
	if ((zoom < standardZoomLevel || zoom > indoorZoomLevel)) {
	  highlightedBuilding.setStyle({
	    fillOpacity: 0.0,
	  });
	}
  }
  // reset the highlighted building to be undefined
  highlightedBuilding = null;
  // if no new position was provided, do nothing
  if(!position) {
    return;
  }
  // different representation of the position for the pointInPolygon-method
  position = [position.lng, position.lat];
    
  // set the new style for the clicked destination
  for (const campus of campusNames) {
    let buildingsOfCampus = layers[campus]._layers;
    
    for (const id in buildingsOfCampus) {
      const buildingId = Number(id)
      const polygonCoordinates = buildingsOfCampus[buildingId]._layers[buildingId-1].feature.geometry.coordinates[0];

      // if our point is within the building polygon, we change it's style and remember it as the currently highlighted building
      if(pointInPolygon(position, polygonCoordinates)) {
        highlightedBuilding = buildingsOfCampus[buildingId];
		setStyleForHighlightedBuilding()
		return;
      }
    }
  }
}

function buildNavigationButton(){
  const el = document.createElement('div')
  el.className = 'leaflet-navigation-button leaflet-control leaflet-control-layers';
  el.id = 'leaflet-navigation-button'
  el.innerHTML = 	`
    <i 
      class="fa fa-route fa-3x navigation-icon"
      onclick="
        document.getElementById('map-navigation-popup').style.display = 'inline';
        event.stopPropagation();
        document.getElementById('map-popup').style.display = 'none';"
    >
    </i>
  `
  document.querySelector('.leaflet-right').appendChild(el)
};
buildNavigationButton();

document.getElementsByClassName('leaflet-routing-collapse-btn')[0].style.display = 'none'

// move rounting container to map-navigation-popup
let element = document.getElementsByClassName('leaflet-routing-container')[0];
let parent = element.parentNode;
let targetDiv = document.getElementById('routing-controller');
targetDiv.appendChild(element);


function navigateTo(position) {
  // .locate() function returns map, so chaining works
  mymap.locate()
  .off('locationfound')
  .on('locationfound', function(e){
    routingControl.setWaypoints([e.latlng, position])
  })
  .off('locationerror')
  .on('locationerror', function(e){
    console.log("location error. Use previous start point for navigation")
    const previousStart = routingControl.getWaypoints()[0]
    routingControl.setWaypoints([previousStart, position])
  });
}

function onMapClick(e) {
  navigateTo(e.latlng)
}

// Build the stop buton and insert it into the routingControl-plan
function buildStopButton() {
    const el = document.createElement('div')
    el.className = 'leaflet-routing-geocoder-stop';
    el.innerHTML = 	`
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
    />`
    // Do not render the '+' button that can be used to add waypoints
    document.querySelector('.leaflet-routing-add-waypoint').style.display = 'none'
    // Add our Stop button to the routingControl-plan
    document.querySelector('.leaflet-routing-geocoders').appendChild(el)
};
buildStopButton();

mymap.on('click', onMapClick);

// Per default, we don't want the stop button to be shown, as there is no route
document.getElementById('StopNavigation').style.display = 'none';
