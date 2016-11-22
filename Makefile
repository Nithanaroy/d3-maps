build/cb_2015_us_county_20m.zip:
	mkdir -p $(dir $@)
	curl -o $@ http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_county_20m.zip