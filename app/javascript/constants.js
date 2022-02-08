export const standardZoomLevel = 17;
export const indoorZoomLevel = 19;
export const leafletMapId = "map";

const hpiRed = "#b0063a";

export const UniPotsdamStyle = {
  fillColor: "Blue",
  fillOpacity: 0.65,
  color: "Blue",
  opacity: 0.3,
};

export const HPIStyle = {
  fillColor: "Orange",
  fillOpacity: 0.65,
  color: "Orange",
  opacity: 0.3,
};

export const DormStyle = {
  fillColor: "Green",
  fillOpacity: 0.65,
  color: "Green",
  opacity: 0.3,
};

export const IndoorStyle = {
  fillOpacity: 0.0,
  color: "#444",
};

export const EntranceStyle = {
  fillColor: "Red",
  fillOpacity: 0.65,
  color: "Red",
  opacity: 0.3,
};

export const PoIStyle = {
  fillColor: "Black",
  fillOpacity: 0.65,
  color: "Black",
  opacity: 0.3,
};

export const HighlightedBuildingStyle = {
  fillColor: hpiRed,
  fillOpacity: 0.65,
  color: hpiRed,
  opacity: 0.3,
};

export const styleMap = {
  "UP Campus Griebnitzsee": UniPotsdamStyle,
  "Campus I": HPIStyle,
  "Campus II": HPIStyle,
  "Campus III": HPIStyle,
  "Studentendorf Stahnsdorfer Straße": DormStyle,
  HighlightedBuilding: HighlightedBuildingStyle,
  default: UniPotsdamStyle,
};

export const redMarkerIcon = new L.Icon({
  iconUrl:
    "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png",
  shadowUrl:
    "https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png",
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  shadowSize: [41, 41],
});
