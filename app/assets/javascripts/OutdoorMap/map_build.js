// import L from 'leaflet';x
// import 'leaflet.locatecontrol';

const L = window.L

// Set the leaflet map with center and zoom-level
const standardZoomLevel = 17;
const indoorZoomLevel = 19;
var mymap = L.map('map').setView([52.39300, 13.12900], standardZoomLevel);

// Tileserver to be used as background
L.tileLayer('https://api.maptiler.com/maps/basic/{z}/{x}/{y}.png?key=teiAXvgYrHq2mifMtHYX',{
    tileSize: 512,
    zoomOffset: -1,
    minZoom: 1,
    maxZoom: 23,
    attribution: "\u003ca href=\"https://www.maptiler.com/copyright/\" target=\"_blank\"\u003e\u0026copy; MapTiler\u003c/a\u003e \u003ca href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\"\u003e\u0026copy; OpenStreetMap contributors\u003c/a\u003e | Schnavigator",
    crossOrigin: true
}).addTo(mymap);

L.control.locate({
    locateOptions: {
        watch: true,
        enableHighAccuracy: true
    }
}).addTo(mymap);

var UniPotsdamStyle = {
    "fillColor": "Blue",
    "fillOpacity": 0.65,
    "color": "Blue",
    "opacity": 0.3
};

var HPIStyle = {
    "fillColor": "Orange",
    "fillOpacity": 0.65,
    "color": "Orange",
    "opacity": 0.3
};

var DormStyle = {
    "fillColor": "Green",
    "fillOpacity": 0.65,
    "color": "Green",
    "opacity": 0.3
};

let layers = {}

// buildings includes all geometry-data extracted from OSM, see campus.js
// layers has the "feature" property as index, e.g. "Studentendorf Stahnsdorfer Straße"
for (const feature of buildings) {
    // If the current campus (=group of buildings) is unknown, create a layergroup for it
    if(!layers[feature.properties.campus]) {
        layers[feature.properties.campus] = L.layerGroup().addTo(mymap);
        // console.log("Added the following campus to layers: ", feature.properties.campus);
    }

    // Determine Style (highlighting-colour) dependent of group
    let layerStyle = UniPotsdamStyle;
    switch(feature.properties.campus) {
        case 'UP Campus Griebnitzsee': layerStyle = UniPotsdamStyle;
            break;
        case "Campus I": layerStyle = HPIStyle;
            break;
        case "Campus II": layerStyle = HPIStyle;
            break;
        case 'Campus III': layerStyle = HPIStyle;
            break;
        case "Studentendorf Stahnsdorfer Straße": layerStyle = DormStyle;
            break;
        default: console.log("This building does not belong to a known campus: ", feature);
            break;
    }

    // Add the building as a layer
    const layer = L.geoJSON(feature, { style: layerStyle });
    // Add a tooltip displaying the name of the building, taken from the GeoJSON
    layer.bindTooltip(feature.properties.name, { permanent: true, className: 'marker_label', offset: feature.properties.offset, direction: 'right' })
    // Add the building to its campus layergroup
    layers[feature.properties.campus].addLayer(layer);
}

// make names disappeared when zoomed out
var lastZoom;
mymap.on('zoomend', function () {
    var zoom = mymap.getZoom();
    if ((zoom < standardZoomLevel || zoom > indoorZoomLevel) && (!lastZoom || lastZoom >= standardZoomLevel || lastZoom <= indoorZoomLevel)) {
        mymap.eachLayer(function (layer) {
            if (layer.getTooltip()) {
                var tooltip = layer.getTooltip();
                layer.unbindTooltip().bindTooltip(tooltip, {
                    permanent: false
                })
            }
        })
    } else if (zoom >= standardZoomLevel && zoom <= indoorZoomLevel && (!lastZoom || (lastZoom < standardZoomLevel || lastZoom > indoorZoomLevel))) {
        mymap.eachLayer(function (layer) {
            if (layer.getTooltip()) {
                var tooltip = layer.getTooltip();
                layer.unbindTooltip().bindTooltip(tooltip, {
                    permanent: true
                })
            }
        });
    }
    lastZoom = zoom;
})

L.control.layers(null, layers).addTo(mymap);


var popup = L.popup();

positions = []

// TomTom Routing API-key: peRlaISfnHGUKWZpRw4O11yc3B4Ay2t5
// mapbox API key sk.eyJ1IjoicHZpaSIsImEiOiJja3g1MnhkdGQxMTlzMm5xa3FpNzlrcHYxIn0.ZX0lMZW2IofVpmIJQtHUmA

// mapbox token

console.log(window.location.host + '/directions')

// routingControl does everything related to navigation
let routingControl = L.Routing.control({
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
    document.getElementById('StopNavigation').style.display = 'block';
})
.on('waypointschanged', (e)=>{
	// this handler is called whenever the waypoints are changed in any way (search bar or clicking in the map)
	waypoints = routingControl.getWaypoints()
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
controlContainerParent.removeChild(routingControlContainer);
console.log(document.documentElement.innerHTML);

var newDiv = document.getElementById("marie");
newDiv.appendChild(routingControlContainer);

function onMapClick(e) {
    pos = e.latlng
    positions.push(pos)
    // by inserting a third waypoint, the very first inserted waypoint won't be considered for the route anymore
    if (positions.length === 3) {
        positions.shift()
	}
	// all the calculations will be done within the 'waypointschanged' handler of the routingControl
	routingControl.setWaypoints(positions)
}

// Build the stop buton and insert it into the routingControl-plan
(function buildStopButton(){
    const el = document.createElement('div')
    el.className = 'leaflet-routing-geocoder';
    el.innerHTML = 	`
    <input 
        type="button" 
        id="StopNavigation" 
        value="Stop" 
        onclick="stopNavigation(event)" 
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

// Sets positions to an empty array and passes it to the router, essentially routing an empty route which is our "stop" functionality
function stopNavigation(e){
	e.stopPropagation();
    document.getElementById('StopNavigation').style.display = 'none';
	positions = []
	routingControl.hide()
    routingControl.setWaypoints(positions).route()
}

mymap.on('click', onMapClick);

// Per default, we don't want the stop button to be shown, as there is no route
document.getElementById('StopNavigation').style.display = 'none';