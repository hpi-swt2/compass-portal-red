import {IndoorStyle} from "../constants";

const buildRoomLayer = (room) => {
    if(mymap == null) throw Error('Map not initialized before buildRoomLayer was called.')

    const roomLayer = L.geoJSON(room.geoJson,
        {
            style: {
                ...IndoorStyle,
                color: 'rgba(0, 0, 0, 0)',
            },
            pane: 'rooms',
        }
    );
    
    const roomTooltip = L.tooltip({
        permanent: true,
        interactive: true,
        className: 'marker_label',
        offset: L.point(0, 0),
        direction: 'center',
    });
    roomTooltip.setContent(room.fullName);
    console.log("CHIMPANSE")
    roomLayer.bindTooltip(roomTooltip);
    roomLayer.addEventListener('click',  (event) =>  {
        // TODO: fix routing error in console
        console.log(event);
        const popupRootNode = document.getElementById("popup_root")
        if(popupRootNode.hasChildNodes){
            try{
                const currentRoomPopUp = popupRootNode.childNodes[0]
                popupRootNode.removeChild(currentRoomPopUp)
            }
            catch(e){
                console.error("Failed removing child node", e)
            }
        } 
        
        const element = document.createElement('div')
        element.innerHTML = `<div class="map-popup card shadow-sm p-2">
        <div class="card-body">
        ⏳ Loading    
        </div></div>`
        console.log("appending child")
        popupRootNode.appendChild(element)

        fetch("/map/room_popup/"+room.id).then(function (response) {
            return response.text();
        }).then(function (html) {
            element.innerHTML = html
        }).catch(function (err) {
            console.warn('Sum ting went wrong.', err);
            element.innerHTML = 'Sum ting went wrong: \n'+err
        })    
    });

    layers[room.fullName] = L.layerGroup()
        .addTo(mymap)
        .addLayer(roomLayer);

    roomLayer.closeTooltip(roomTooltip);
}

export const buildIndoorMap = () => {
    console.log('[INDOOR] Indoor map start');
    if(window.roomsToBuild == null) {
        console.error('Expected to receive rooms to build, but "roomsToBuild" is null.');
    } else {
        mymap.createPane('rooms');

        window.roomsToBuild.forEach(room => {
            buildRoomLayer(room)
        })
    }
    console.log('[INDOOR] Indoor map done');
}

buildIndoorMap();