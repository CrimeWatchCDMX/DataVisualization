#######################################################Case study 10 script ################################
library(tidyverse)
library(buildings)
library(USAboundaries)
library(stringr)
  


states <- us_states() %>%
  filter(state_abbr != "AK" & state_abbr != "PI" & state_abbr != "HI") %>%
  mutate(State = state_abbr)

ca_cont <- us_counties() %>%
  filter(state_abbr == "CA")


ca_perm <- permits %>%
  filter(variable == "Single Family" & StateAbbr == "CA") %>%
  mutate(name = str_sub(countyname, end = -8)) %>%
  group_by(name, year) %>%
  summarise(sum(value)) %>% 
  mutate(pct_change = (`sum(value)`/lag(`sum(value)`) - 1) * 100) %>%
  mutate(abr = "CA")



p <-  permits %>%
  filter(variable == "Single Family") %>%
  group_by(StateAbbr, year) %>%
  summarise(sum(value)) %>% 
  mutate(pct_change = (`sum(value)`/lag(`sum(value)`) - 1) * 100) %>%
  mutate(State = StateAbbr) %>%
  mutate(permits = `sum(value)`)


country_data <- inner_join(states, p, by = "State")

ca_data <- inner_join(ca_perm, ca_cont, by = "name")

country_data %>%
  filter(between(year, 1999,2010)) %>%
  filter(between(pct_change, -90, 100)) %>%
  ggplot() +
  geom_sf(aes(fill = pct_change)) +
  scale_fill_gradient2(low = "red", mid = "white",
                       high = "green", midpoint = 0,
                       na.value = "grey50") +
  facet_wrap(~year) +
  labs(fill = "Percent Change", title = "Trends in U.S. Housing Starts", subtitle = "(1999 - 2010)") +
  theme_bw() +
  theme(legend.position = "bottom")


ca_data %>%
  filter(between(year, 1999,2010)) %>%
  filter(between(pct_change, -90, 100)) %>%
  ggplot() +
  geom_sf(aes(fill = pct_change)) +
  scale_fill_gradient2(low = "red", mid = "white",
                       high = "green", midpoint = 0,
                       na.value = "grey50") +
  facet_wrap(~year) +
  labs(fill = "Percent Change", title = "Trends in CA Housing Starts", subtitle = "(1999 - 2010)") +
  theme_bw() +
  theme(legend.position = "bottom")
  