import { IndoorStyle } from '../constants';

const buildRoomLayer = (room) => {
  if (mymap == null)
    throw Error('Map not initialized before buildRoomLayer was called.');

  const roomLayer = L.geoJSON(room.geoJson, { style: IndoorStyle });
  const roomTooltip = L.tooltip({
    permanent: true,
    interactive: true,
    className: 'marker_label',
    offset: L.point(0, 0),
    direction: 'center',
  });
  roomTooltip.setContent(room.fullName);

  roomLayer.bindPopup(
    `<a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ" target="_blank">${room.fullName}</a>`
  );

  roomLayer.bindTooltip(roomTooltip);
  roomLayer.addEventListener('click', (event) => {
    console.log(event);
  });

  return L.layerGroup().addTo(mymap).addLayer(roomLayer);
};

const buildFloorLayer = (floor) => {
  if (mymap == null)
    throw Error('Map not initialized before buildRoomLayer was called.');

  // Add FloorLayer to layers
  const floorLayer = L.layerGroup().addTo(mymap);
  layers[floor.name] = floorLayer;

  // Add all rooms
  floor.rooms.forEach((room) => {
    const roomLayer = buildRoomLayer(room);
    layers[floor.name].addLayer(roomLayer);
  });

  return floorLayer;
};

export const buildIndoorMap = () => {
  console.log('[INDOOR] Indoor map start');

  if (window.floorsToBuild == null) {
    console.error(
      'Expected to receive rooms to build, but "floorsToBuild" is null.'
    );
  } else {
    const floorLayers = {};
    window.floorsToBuild.forEach((floor) => {
      floorLayers[floor.name] = buildFloorLayer(floor);
    });
    L.control.layers(floorLayers, null).addTo(mymap);
  }
  console.log('[INDOOR] Indoor map done');
  console.log(layers);
};

buildIndoorMap();
