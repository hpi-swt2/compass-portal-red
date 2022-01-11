const {indoorZoomLevel} = require("./constants");

// Timeout to make sure that init of other code is done
// TODO: Find nicer solution (e.g. JS CustomEvent)
setTimeout(() => {
    console.log('[SELECTED_ROOM] Selected room start');
    const coordinates = window.selected_room_coordinates
    L.marker(coordinates).addTo(mymap);
    mymap.setView(coordinates, indoorZoomLevel);
    console.log('[SELECTED_ROOM] Selected room done');
}, 100);