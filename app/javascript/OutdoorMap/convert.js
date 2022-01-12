import * as fs from "fs";
// DO NOT INCLUDE THIS TO RAILS
// this is meant to be executed via the command line
// How to get data:
// 1. Go to https://www.openstreetmap.org/#map=18/52.39328/13.13109&layers=D
// 2. Go to export tab
// 3. select desired area and click json
// 4. place result here and execute "npx osmtogeojson map.osm > map.geojson"
// 5. add desired buildings and properties to the list below. properties will be morged with OSM properties
// 6. run this script to get desired buildings with properties
// current file is bounded from 52.3978 to 52.3848 and 13.1187 to 13.1524

const interestingBuildings = {
  // name: "HPI-Hörsaalgebäude"
  "way/23133703": {
    properties: {
      campus: "Campus I",
    },
  },
  // HPI-Hauptgebäude
  "way/79387302": {
    properties: {
      campus: "Campus I",
    },
  },
  // Haus C
  "way/608073743": {
    properties: {
      campus: "Campus I",
    },
  },
  // Haus B
  "way/608073744": {
    properties: {
      campus: "Campus I",
    },
  },
  // Haus A
  "way/608073747": {
    properties: {
      campus: "Campus I",
    },
  },
  // Bibliothek
  "way/23133702": {
    properties: {
      campus: "UP Campus Griebnitzsee",
    },
  },
  // Mensagebäude
  "way/24605639": {
    properties: {
      campus: "UP Campus Griebnitzsee",
    },
  },
  // Haus 1 UP Mitte
  "way/495731468": {
    properties: {
      campus: "UP Campus Griebnitzsee",
    },
  },
  // Haus 2 UP süd
  "way/495731470": {
    properties: {
      campus: "UP Campus Griebnitzsee",
    },
  },
  // Haus 2 UP Nord
  "way/495731458": {
    properties: {
      campus: "UP Campus Griebnitzsee",
    },
  },
  // Haus 7 UP
  "way/202284137": {
    properties: {
      campus: "UP Campus Griebnitzsee",
    },
  },
  // Haus F
  "way/495731455": {
    properties: {
      campus: "Campus II",
    },
  },
  // Haus E
  "way/202282411": {
    properties: {
      campus: "Campus II",
    },
  },
  // Haus D
  "way/79813023": {
    properties: {
      campus: "Campus II",
    },
  },
  // Villa
  "way/23133708": {
    properties: {
      campus: "Campus II",
    },
  },
  // Haus G
  "way/190868129": {
    properties: {
      campus: "Campus III",
    },
  },
  // Haus G Nordosttteil
  "way/496343326": {
    properties: {
      campus: "Campus III",
    },
  },
  // Haus G Nordwestteil
  "way/496343327": {
    properties: {
      campus: "Campus III",
    },
  },
  // Stahnsdorfer 140
  "way/23133696": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 142
  "way/23133697": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 144
  "way/23133693": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 146
  "way/23133692": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 148
  "way/23133694": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 150
  "way/23133695": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 152
  "way/23133698": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 154
  "way/23133699": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
  // Stahnsdorfer 156
  "way/23133700": {
    properties: {
      campus: "Studentendorf Stahnsdorfer Straße",
    },
  },
};

const map = JSON.parse(fs.readFileSync("map.geojson", "utf-8"));
const result = [];
for (const feature of map.features) {
  const entry = interestingBuildings[feature.id];
  if (!entry) {
    continue;
  }
  feature.properties = Object.assign({}, feature.properties, entry.properties);
  console.log(feature);
  result.push(feature);
}

fs.writeFileSync(
  "../javascripts/CampusGeometry/campus.js",
  "let buildings = JSON.parse('" +
    JSON.stringify(result).replace(/\'/g, "\\'") +
    "')"
);
