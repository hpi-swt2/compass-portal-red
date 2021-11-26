# Polygons in OSM

## Understanding OSM

I suggest the following website when working with OSM:
- https://osm.org/go/0MZiLXpXM--?layers=D

In order to see the defined Polygons, you need to enable `Map Data` in the `Map Layers`-tab on the right-hand side. This will enable you to click on the blue borders of a Polygon to display its information.
OSM differentiates between three different types of Polygons:
- Relation
- Way
- Node

We only need Relations and Ways for our purposes. A Relation is a collection of Polygons, while a Way is a singular Polygon. Try it out and select the HPI Main Building. When selected you will see its information on the left-hand side of the screen, in our case you should see `Way: HPI Main Building (79387302)`, where `HPI Main Building` is the Way's name and `79387302` is its ID, you will need this later. If you scroll down in the panel, you will see that the Main building is part of 1 relation, the `HPI Campus I (7691202)`. Clicking on it will open the relation. You can see that this Relation consists of three Polygons (Ways), denoted under the `Members`-section in the info-panel.

## Exporting a Polygon as GeoJSON

In order to use the Polygons in our Map, we of course want to export them. The format we will use is `GeoJSON`.
To export your Polygon, use the following website:
- https://overpass-turbo.eu/

### Using Overpass-turbo
Before exporting your Polygon, you should decide whether to export a `Relation` or a `Way`. When choosing a Relation, you will only be able to "communicate" with it as a whole, e.g. you will only be able to decide to highlight the whole of Campus I instead of only the Main Building. For more flexibility, exporting Ways would therefore be better, even though it is slightly more work in the beginning.
In order to find the Relations/Ways you first need to navigate the map to the HPI Campus (i.e. the Polygon in question needs to be visible). Then you need to get the Relation/Way name from the OSM-Website. On the top of the overpass-page choose `Wizard` and enter 
```console
name="yourRelationName"
```
and choose `build and run query`. If the name was correctly entered, the Relation/Way should be highlighted on the map. Then, choose `Export` and `copy` the `GeoJSON` data into your clipboard. Then, you can define a new variable in the `app/assets/javascripts/CampusGeometry`-files, whereever it fits best.

## Highlighting an imported Polygon
After having declared a variable for the Polygon, you need to add it as a layer to the map (in the future, we will try and introduce LayerGroups to group together e.g. Campus I buildings).
Our map is defined in `app/views/map.html.erb`. Make sure to first include your variable by using 
```console
<%= javascript_include_tag 'CampusGeometry/FileWithTheVariable' %>
```
Let's say your new Polygon is called `HPIMainBuilding`, the following command would add it to the map:
```console
L.geoJSON(HPIMainBuilding, {style: HPIStyle}).addTo(mymap);
```
The style option defines what color the highlight will be, for now we have two defined styles, `HPIStyle` and `UniPotsdamStyle` which result in orange and dark blue highlights.