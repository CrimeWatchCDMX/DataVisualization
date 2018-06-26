################### Class task 19 ###########################

library(tidyverse)
library(sf)
library(USAboundaries)
library(USAboundariesData)


cities <- us_cities() %>%
  filter(population > 500000)

st <- us_states() %>%
  filter(state_name != "Alaska" & state_name != "Puerto Rico" & state_name != "Hawaii")

county <- us_counties() %>%
  filter(state_name == "Idaho")


ggplot() +
  geom_sf(data = st) +
  geom_sf(data = county) +
  geom_sf(data = cities, aes(geometry = st_geometry(cities), size = population)) +
  theme_minimal() +
  ggsave("usa.png")
