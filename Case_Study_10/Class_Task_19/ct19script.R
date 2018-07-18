################### Class task 19 ###########################

library(tidyverse)
library(sf)
library(USAboundaries)
library(USAboundariesData)


cities <- us_cities() %>%
  filter(population > 500000)

states <- us_states() %>%
  filter(state_name != "Alaska" & state_name != "Puerto Rico" & state_name != "Hawaii")

idaho <- us_counties() %>%
  filter(state_name == "Idaho")


ggplot() +
  geom_sf(data = states_tr) +
  geom_sf(data = idaho_tr) +
  geom_sf(data = cities, aes(geometry = st_geometry(cities))) +
  theme_minimal() 


my_proj <- "+proj=robin +lon_0=0 +x_0=10 +y_0=10 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
my_proj <- "+proj=moll +lat_0=45 +lon_0=-115 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"

states_tr <- states %>% st_transform( crs = 102003)
idaho_tr <- idaho %>% st_transform( crs = 102003)
