import {IndoorStyle} from "../constants"
import {startNavigation} from "./outdoor_map_builder"
const buildRoomLayer = (room) => {
    if(mymap == null) throw Error('Map not initialized before buildRoomLayer was called.')

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
    roomLayer.bindTooltip(roomTooltip);
    roomLayer.addEventListener('click',  (event) =>  {
        // TODO: fix routing error in console
        showRoomPopup(room.id)
    });

    layers[room.fullName] = roomLayer;

    return roomLayer;
  }

  export function showRoomPopup(roomId){
    const popupRootNode = document.getElementById("popup_root")
    if(popupRootNode.hasChildNodes){
        try{
          
            const children = [...popupRootNode.childNodes]
            console.log("Popup root node has child nodes. Removing them..", children)
            if(children){
              children.forEach(c => popupRootNode.removeChild(c))
            }
        }
        catch(e){
            console.error("Failed removing child node", e)
        }
    } 
    const routingNode = document.getElementById('map-navigation-popup')
    if(routingNode){
      routingNode.style.display = "none"
    }

    const element = document.createElement('div')
    element.innerHTML = `<div class="map-popup card shadow-sm p-2">
    <div class="card-body fw-bold">
    ⏳ Loading    
    </div></div>`
    popupRootNode.appendChild(element)

    fetch("/map/room_popup/"+roomId).then(function (response) {
        return response.text();
    }).then(function (html) {
        element.innerHTML = html
        const navBtn = element.querySelector("#navigate_btn")
        navBtn.onclick= function(){
          console.log("Starting navigation", room)
          popupRootNode.removeChild(element)
          startNavigation()
        }
    }).catch(function (err) {
        console.warn('Sum ting went wrong.', err);
        element.innerHTML = 'Sum ting went wrong: \n'+err
    })    
  }


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
  console.log("[INDOOR] Indoor map start");

  if (mymap == null) {
    console.error('Expected mymap, but "mymap" is null.');
  } else if (window.floorsToBuild == null) {
    console.error(
      'Expected to receive floors to build, but "floorsToBuild" is null.'
    );
  } else {
    mymap.createPane("rooms");

    const floorLayers = {};
    window.floorsToBuild.forEach((floor) => {
      floorLayers[floor.name] = buildFloorLayer(floor);
    });
    L.control.layers(floorLayers, null).addTo(mymap);
  }
  console.log("[INDOOR] Indoor map done");
};

buildIndoorMap();
