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
    const layer = L.geoJSON(feature, {style: layerStyle});
    // Add a tooltip displaying the name of the building, taken from the GeoJSON
    layer.bindTooltip(feature.properties.name, {permanent: true, className: 'marker_label', offset: feature.properties.offset, direction: 'right'})
    // Add the building to its campus layergroup
    layers[feature.properties.campus].addLayer(layer);
}

//Add points of interest
layers['Points of Interest'] = L.layerGroup().addTo(mymap);
let pois = JSON.parse(document.getElementById('poi-data').dataset.source);
for(const feature of pois) {
    const layer = L.geoJSON(feature);
    layer.bindTooltip(feature.properties.name, {permanent: true, className: 'marker_label', offset: [-14, 0], direction: 'right'})
    layer.bindPopup(feature.properties.description);
    layers['Points of Interest'].addLayer(layer);
}

// make names disappear when zoomed out
var lastZoom;
mymap.on('zoomend', function() {
    var zoom = mymap.getZoom();
    if ((zoom < standardZoomLevel || zoom > indoorZoomLevel) && (!lastZoom || lastZoom >= standardZoomLevel || lastZoom <= indoorZoomLevel)) {
        mymap.removeLayer(layers['Points of Interest']);
        mymap.eachLayer(function(layer) {
            // TODO right now the tooltips of all layers, including rooms, are removed
            if (layer.getTooltip()) {
                var tooltip = layer.getTooltip();
                layer.unbindTooltip().bindTooltip(tooltip, {
                    permanent: false
                })
            }
        });
    } else if (zoom >= standardZoomLevel && zoom <= indoorZoomLevel && (!lastZoom || (lastZoom < standardZoomLevel || lastZoom > indoorZoomLevel))) {
        mymap.addLayer(layers['Points of Interest']);
        mymap.eachLayer(function(layer) {
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
