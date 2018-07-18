############################### Task 17
library(tidyverse)
library(sf)

idaho <- st_read('County-AK-HI-Moved-USA-Map.shp')
dam <- st_read('dam.shp')
water <- st_read('hyd250.shp')
wells <- st_read('wells.shp')



id <- idaho %>%
  filter(StateName == "Idaho") %>%
  st_transform(crs = 2789)

nake <- water %>% 
  filter(FEAT_NAME == "Snake River")

damn <- dam %>%
  filter(SurfaceAre > 50)

well <- wells %>%
  filter(Production > 5000)

  ggplot() +
  geom_sf(data = id) +
  geom_sf(data = nake, color = 'blue', size = 1.5) +
  geom_sf(data = damn, color = 'white') +
  geom_sf(data = well, aes(color = Production)) +
    theme_minimal() +
    labs(main = 'Idaho Wells and Dams') +
    ggsave('task20.png')


