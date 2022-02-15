import { IndoorStyle } from '../constants'
import { startNavigation } from './outdoor_map_builder'
const buildRoomLayer = (room) => {
  if (mymap == null)
    throw Error('Map not initialized before buildRoomLayer was called.')

  const roomLayer = L.geoJSON(room.geoJson, {
    style: IndoorStyle,
    pane: 'rooms',
  })

  const roomTooltip = L.tooltip({
    permanent: true,
    interactive: true,
    className: 'marker_label',
    offset: L.point(0, 0),
    direction: 'center',
  })
  roomTooltip.setContent(room.fullName)
  roomLayer.bindTooltip(roomTooltip)
  roomLayer.addEventListener('click', (event) => {
    // TODO: fix routing error in console
    showRoomPopup(room.id)
  })

  layers[room.fullName] = roomLayer

  return roomLayer
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

  fetch('/map/room_popup/' + roomId)
    .then(function (response) {
      return response.text()
    })
    .then(function (html) {
      element.innerHTML = html
      const navBtn = element.querySelector('#navigate_btn')
      navBtn.onclick = function () {
        console.log('Starting navigation', room)
        popupRootNode.removeChild(element)
        startNavigation()
      }
    })
    .catch(function (err) {
      console.warn('Sum ting went wrong.', err)
      element.innerHTML = 'Sum ting went wrong: \n' + err
    })
}

const buildFloorLayer = (floor) => {
  // Add FloorLayer to layers
  const floorLayer = L.layerGroup()
  layers[floor.name] = floorLayer
  // Add all rooms
  floor.rooms.forEach((room) => {
    const roomLayer = buildRoomLayer(room)
    layers[floor.name].addLayer(roomLayer)
  })
  return floorLayer
}

export const buildIndoorMap = () => {
  console.log('[INDOOR] Indoor map start')

  if (mymap == null) {
    console.error('Expected mymap, but "mymap" is null.')
  } else if (window.floorsToBuild == null) {
    console.error(
      'Expected to receive floors to build, but "floorsToBuild" is null.'
    )
  } else {
    mymap.createPane('rooms')

    let floorLayers = {}
    window.floorsToBuild.forEach((building) => {
      building.floors.forEach((floor) => {
        floorLayers[floor.name] = buildFloorLayer(floor)
      })
    })
    // Needed for adding the red box
    const temp = {}
    let alreadyActivatedBuilding = []
    for (const key in floorLayers) {
      // loop through the rooms of the current floor and check if the selected room is there by making an array of booleans
      // needs to be an array of bools since window.floorsToBuild[counter].rooms is an object and not an array so I cannot just
      // check if it includes a certain value
      for (let i = 0; i < window.floorsToBuild.length; i++) {
        window.floorsToBuild[i].floors.forEach((floor) => {
          if (floor.name === key) {
            const result = floor.rooms.map(
              (room) => room.fullName === selected_room_name
            )
            if (selected_room_name) {
              // if there is a selected room then activate only the layer where this room is and make it red
              if (result.includes(true)) {
                temp[
                  `<span style='background-color: #e0938d; padding: 5px; border-radius: 10px;'>${key}</span>`
                ] = floorLayers[key]
                // activating the layer with the selected room by default
                mymap.addLayer(
                  temp[
                    `<span style='background-color: #e0938d; padding: 5px; border-radius: 10px;'>${key}</span>`
                  ]
                )
              } else {
                temp[`<span>${key}</span>`] = floorLayers[key]
              }
            } else {
              // if there is no selected room then activate one layer for every building
              temp[`<span>${key}</span>`] = floorLayers[key]
              if (
                !alreadyActivatedBuilding.includes(
                  window.floorsToBuild[i].building
                )
              ) {
                // if there is no floor activated for this building already, activate the current one
                alreadyActivatedBuilding.push(window.floorsToBuild[i].building)
                mymap.addLayer(temp[`<span>${key}</span>`])
              }
            }
          }
        })
      }
    }
    floorLayers = temp

    // converts every string to snake case (that_is_this_case)
    const snakeCase = (string) => {
      return string
        .replace(/\W+/g, ' ')
        .split(/ |\B(?=[A-Z])/)
        .map((word) => word.toLowerCase())
        .join('_')
    }

    // creating a different controller for every building
    for (let i = 0; i < window.floorsToBuild.length; i++) {
      const tempFloors = []
      // getting all floor names of the current building
      window.floorsToBuild[i].floors.forEach((floor) => {
        tempFloors.push(floor.name)
      })
      const tempLayers = []
      for (const key in floorLayers) {
        var doc = new DOMParser().parseFromString(key, 'text/xml')
        const result = doc.firstChild.innerHTML // taking the content of the <span> tag
        if (tempFloors.includes(result)) tempLayers[key] = floorLayers[key]
      }
      const container = L.control
        .layers(tempLayers, null, {
          collapsed: false,
        })
        .addTo(mymap)
        .getContainer()

      container.classList.add('buildings_control_container')
      container.children[1].firstElementChild.setAttribute(
        'class',
        `${snakeCase(window.floorsToBuild[i].building)}_controller`
      ) // Needed for adding this Header
      $(`<h6>${window.floorsToBuild[i].building}</h6>`).insertBefore(
        `div.${snakeCase(window.floorsToBuild[i].building)}_controller`
      )
    }
  }
  // hiding all contollers intially since the map is not zoomed in
  document
    .querySelectorAll('.buildings_control_container')
    .forEach((el) => (el.style.display = 'none'))
  console.log('[INDOOR] Indoor map done')
}

buildIndoorMap()
