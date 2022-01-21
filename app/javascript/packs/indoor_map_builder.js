import { IndoorStyle } from '../constants';

const buildRoomLayer = (room) => {
  const roomLayer = L.geoJSON(room.geoJson, {
    style: IndoorStyle,
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

  return L.layerGroup().addLayer(roomLayer);
};

const buildFloorLayer = (floor) => {
  // Add FloorLayer to layers
  const floorLayer = L.layerGroup();
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
    console.error('Expected mymap, but "mymap" is null.');
  } else if (window.floorsToBuild == null) {
    console.error(
      'Expected to receive floors to build, but "floorsToBuild" is null.'
    );
  } else {
    mymap.createPane('rooms');

    const floorLayers = {};
    window.floorsToBuild.forEach((floor) => {
      floorLayers[floor.name] = buildFloorLayer(floor);
    });
    L.control.layers(floorLayers, null).addTo(mymap);

    // Hide tooltips by default
    mymap.eachLayer(function (layer) {
      if (layer.getTooltip()) {
        const tooltip = layer.getTooltip();

        if (layer.options.pane === 'rooms') {
          layer.closeTooltip(tooltip);
        }
      }
    });
  }
  console.log('[INDOOR] Indoor map done');
};

buildIndoorMap();
