import {IndoorStyle} from "./constants";

const buildRoomLayer = (room) => {
    if(mymap == null) throw Error('Map not initialized before buildRoomLayer was called.')

    const roomLayer = L.geoJSON(room.geoJson,
        {style: IndoorStyle});
    const roomTooltip = L.tooltip({
        permanent: true,
        interactive: true,
        className: 'marker_label',
        offset: L.point(0, 0),
        direction: 'center',
    });
    roomTooltip.setContent(room.fullName);

    roomLayer.bindPopup(`<a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ" target="_blank">${room.fullName}</a>`);

    roomLayer.bindTooltip(roomTooltip);
    roomLayer.addEventListener('click', (event) => {
        console.log(event);
    });

    layers[room.fullName] = L.layerGroup()
        .addTo(mymap)
        .addLayer(roomLayer);
}

export const buildIndoorMap = () => {
    console.log('[INDOOR] Indoor map start');
    if(window.roomsToBuild == null) {
        console.error('Expected to receive rooms to build, but "roomsToBuild" is null.');
    } else {
        window.roomsToBuild.forEach(room => {
            buildRoomLayer(room)
        })
    }
    console.log('[INDOOR] Indoor map done');
}

buildIndoorMap();