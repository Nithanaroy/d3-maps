## Notes
- Shapefile: vector format for drawing maps
	.shp - shape format. geometry itself
	.shx - shape index format. an index for the tool using the .shp file
	.dbf - columnar attributes that can be stored with shape files

- GDAL: Converts Shapefile to GeoJSON

- GeoJSON & TopoJSON: TopoJSON is an extension to GeoJSON. 80% smaller due to it shared line segments concept where two countries have common border!



						GDAL
Get shapefile  --------------> GeoJSON ---------------> TopoJSON ---------> Show in web

## Data Resources
- http://www.census.gov/geo/maps-data/data/tiger.html
- http://www.naturalearthdata.com/downloads/


## For the course:
- US County Shapefile - http://www.census.gov/geo/maps-data/data/cbf/cbf_counties.html
- `brew install gdal` which exposes `ogr2ogr` command
- Clipping: `ogr2ogr -f GeoJSON out/counties.json inp/cb_2015_us_county_20m.shp`. Get bounding boxes easily for state using https://www.flickr.com/places/info/2347563. Generate json for a clipped region, like CA in USA `ogr2ogr -f GeoJSON out.json inp.shp -clipsrc <x_min> <y_min> <x_max> <y_max>`. The example output after filtering in our example should like as shown in exercise_files/counties-clipped.html
- Filtering: To exactly filter a state and not get the entire bounding box, `ogr2ogr -f GeoJSON out.json inp.shp -where "STATEFP='06'"`. State FP codes can be obtained from https://en.wikipedia.org/wiki/Federal_Information_Processing_Standard_state_code and here '06' is for California. The example output after filtering in our example should like as shown in exercise_files/counties-filtered.html
- `npm install -g topojson` exposes geo2json command and can be used to convert geo json files to topo json. `geo2topo -o topo-out.json geo-inp.json`
- Embed D3 projection in topo json using geo2topo, `geo2topo -o topo-counties-projected.json --projection='width = 960, height = 600, d3.geo.albersUsa() .scale(1280) .translate([width / 2, height / 2])' counties.json`. The example output after filtering in our example should like as shown in exercise_files/topo-counties-projected.html
- For going a little accuracy in line drawing of a map, we can reduce download and rendering time values. Visvalingam's line simplication algorithm does this in an elagant and simple to understand manner and is explained at [https://bost.ocks.org/mike/simplify/](). The code for this is `geo2topo -o topo-counties-simplified.json --projection='width = 960, height = 600, d3.geo.albersUsa() .scale(1280) .translate([width / 2, height / 2])' --simplify=.5 counties.json`