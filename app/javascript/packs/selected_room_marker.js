const { indoorZoomLevel } = require("../constants");

// Timeout to make sure that init of other code is done
// TODO: Find nicer solution (e.g. JS CustomEvent)
setTimeout(() => {
  console.log('[SELECTED_ROOM] Selected room start');
  const room = layers[`${selected_room_name}`];
  // TODO: Add message?
  if(!room) return;

  const coordinates = room.getBounds().getCenter();
  L.marker(coordinates).addTo(mymap);
  mymap.setView(coordinates, indoorZoomLevel + 1);
  console.log('[SELECTED_ROOM] Selected room done');
}, 100);
