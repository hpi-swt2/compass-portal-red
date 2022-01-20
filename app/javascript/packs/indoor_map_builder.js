import { IndoorStyle } from '../constants';

const buildRoomLayer = (room) => {
  const roomLayer = L.geoJSON(room.geoJson, {
    style: {
      ...IndoorStyle,
      color: 'rgba(0, 0, 0, 0)',
    },
    pane: 'rooms',
  });

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

  if (mymap == null) {
    console.error('Map not initialized before buildRoomLayer was called.');
  } else if (window.floorsToBuild == null) {
    console.error(
      'Expected to receive rooms to build, but "floorsToBuild" is null.'
    );
  } else {
    mymap.createPane('rooms');

    const floorLayers = {};
    window.floorsToBuild.forEach((floor) => {
      floorLayers[floor.name] = buildFloorLayer(floor);
    });
    L.control.layers(floorLayers, null).addTo(mymap);
  }
  console.log('[INDOOR] Indoor map done');
};

buildIndoorMap();
