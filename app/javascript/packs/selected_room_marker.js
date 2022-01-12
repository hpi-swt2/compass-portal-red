const {indoorZoomLevel} = require("../constants");

// Timeout to make sure that init of other code is done
// TODO: Find nicer solution (e.g. JS CustomEvent)
setTimeout(() => {
    console.log('[SELECTED_ROOM] Selected room start');
    const group = layers[`${selected_room_name}`];
    // TODO: Add message?
    if(!group) return;

    const coordinates = group.getLayers()[0].getBounds().getCenter();
    L.marker(coordinates).addTo(mymap);
    mymap.setView(coordinates, indoorZoomLevel);
    console.log('[SELECTED_ROOM] Selected room done');
}, 100);