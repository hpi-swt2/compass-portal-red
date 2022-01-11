import {buildings} from "./geometry";
import {standardZoomLevel, indoorZoomLevel, styleMap} from "../constants";

console.log('[MAP] Pre map init');

// If the map object still exists, initiate a new one
// (relevant, when the user navigates back and the old page is cached)
if(window.mymap) window.mymap.remove();

// Set the leaflet map with center and zoom-level
window.mymap = L.map('map').setView([52.39300, 13.12900], standardZoomLevel);


console.log('[MAP] Map init done');

// Tileserver to be used as background
L.tileLayer('https://api.maptiler.com/maps/basic/{z}/{x}/{y}.png?key=teiAXvgYrHq2mifMtHYX',{
    tileSize: 512,
    zoomOffset: -1,
    minZoom: 1,
    maxZoom: 23,
    attribution: "\u003ca href=\"https://www.maptiler.com/copyright/\" target=\"_blank\"\u003e\u0026copy; MapTiler\u003c/a\u003e \u003ca href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\"\u003e\u0026copy; OpenStreetMap contributors\u003c/a\u003e | Schnavigator",
    crossOrigin: true
}).addTo(mymap);

console.log('[MAP] Tile layer done');

L.control.locate({
    locateOptions: {
        watch: true,
        enableHighAccuracy: true
    }
}).addTo(mymap);

window.layers = {}

// buildings includes all geometry-data extracted from OSM, see campus.js
// layers has the "feature" property as index, e.g. "Studentendorf Stahnsdorfer Straße"
for (const feature of buildings) {
    // If the current campus (=group of buildings) is unknown, create a layergroup for it
    if(!layers[feature.properties.campus]) {
        layers[feature.properties.campus] = L.layerGroup().addTo(mymap);
        // console.log("Added the following campus to layers: ", feature.properties.campus);
    }

    // Determine Style (highlighting-colour) dependent of group
    let layerStyle = styleMap[feature.properties.campus] ?? styleMap['default'];

    // Add the building as a layer
    const layer = L.geoJSON(feature, {style: layerStyle});
    // Add a tooltip displaying the name of the building, taken from the GeoJSON
    layer.bindTooltip(feature.properties.name, {permanent: true, className: 'marker_label', offset: feature.properties.offset, direction: 'right'})
    // Add the building to its campus layergroup
    layers[feature.properties.campus].addLayer(layer);
}

// make names disappeared when zoomed out
var lastZoom;
mymap.on('zoomend', function() {
    var zoom = mymap.getZoom();
    if ((zoom < standardZoomLevel || zoom > indoorZoomLevel) && (!lastZoom || lastZoom >= standardZoomLevel || lastZoom <= indoorZoomLevel)) {
        mymap.eachLayer(function(layer) {
            // TODO right now the tooltips of all layers, including rooms, are removed
            if (layer.getTooltip()) {
                var tooltip = layer.getTooltip();
                layer.unbindTooltip().bindTooltip(tooltip, {
                    permanent: false
                })
            }
        })
    } else if (zoom >= standardZoomLevel && zoom <= indoorZoomLevel && (!lastZoom || (lastZoom < standardZoomLevel || lastZoom > indoorZoomLevel))) {
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

console.log('[MAP] Layers built');