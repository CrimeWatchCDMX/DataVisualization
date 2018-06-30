############################### Task 17
library(tidyverse)
library(sf)

idaho <- st_read('County-AK-HI-Moved-USA-Map.shp')
damn <- st_read('dam.shp')
water <- st_read('hyd250.shp')
well <- st_read('wells.shp')



id <- idaho %>%
  filter(StateName == "Idaho")

nake <- water %>% 
  filter(FEAT_NAME == "Snake River")


nake %>%
  ggplot() +
  geom_sf(data = id) +
  geom_sf(aes(color = "Blue")) +
  theme_minimal()


