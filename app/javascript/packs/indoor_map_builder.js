import { computeStyles } from '@popperjs/core'
import { IndoorStyle } from '../constants'

const buildRoomLayer = (room) => {
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

  roomLayer.bindPopup(
    `<a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ" target="_blank">${room.fullName}</a>`
  )

  roomLayer.bindTooltip(roomTooltip)
  roomLayer.addEventListener('click', (event) => {
    console.log(event)
  })

  return L.layerGroup().addLayer(roomLayer)
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
    window.floorsToBuild.forEach((floor) => {
      floorLayers[floor.name] = buildFloorLayer(floor)
    })
    // Needed for adding the red box
    const temp = {}
    let counter = 0
    for (const key in floorLayers) {
      // loop through the rooms of the current floor and check if the selected room is there by making an array of booleans
      // needs to be an array of bools since window.floorsToBuild[counter].rooms is an object and not an array so I cannot just
      // check if it includes a certain value
      const result = window.floorsToBuild[counter].rooms.map(
        (room) => room.fullName === selected_room_name
      )
      // if in the result array there is a true value then this means that the selected room is there
      if (result.includes(true)) {
        temp[
          `<span style='background-color: #e0938d; padding: 5px; border-radius: 10px;'>${key}</span>`
        ] = floorLayers[key]
      } else {
        temp[`<span>${key}</span>`] = floorLayers[key]
      }
      counter++
    }
    floorLayers = temp
    console.log(floorLayers['First Floor'])
    const container = L.control
      .layers(floorLayers, null, {
        collapsed: false,
      })
      .addTo(mymap)
      .getContainer()

    container.classList.add('buildings_control_container')
    container.children[1].firstElementChild.setAttribute(
      'class',
      'buildings_control'
    ) // Needed for adding this Header
    $(`<h6>${window.floorsToBuild[0].building}</h6>`).insertBefore(
      'div.buildings_control'
    )
  }
  console.log('[INDOOR] Indoor map done')
}

buildIndoorMap()
