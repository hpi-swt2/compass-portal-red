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

let routingControl = L.Routing.control({
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
.on('routingerror', function(e) {
	try {
		map.getCenter();
	} catch (e) {
		map.fitBounds(L.latLngBounds(positions));
	}
	handleError(e);
});

routingControl.on('routingstart', (e)=>{
    document.getElementById('StopNavigation').style.display = 'block';
})


function onMapClick(e) {
    pos = e.latlng;
    positions.push(pos)
    if (positions.length === 3) {
        positions.shift()
	}
    if (positions.length === 2) {
        routingControl.setWaypoints(positions)
		routingControl.route()
		routingControl.show()
	}
    if (positions.length === 1) {
		routingControl.setWaypoints(positions)
		routingControl.route()
	}
	
}

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
			background-color: white;"
    />`
    document.querySelector('.leaflet-routing-add-waypoint').style.display = 'none '
    document.querySelector('.leaflet-routing-geocoders').appendChild(el)
})()

function stopNavigation(e){
	e.stopPropagation();
    document.getElementById('StopNavigation').style.display = 'none';
	positions = []
	routingControl.hide()
    routingControl.setWaypoints(positions).route()
}

mymap.on('click', onMapClick);

document.getElementById('StopNavigation').style.display = 'none';