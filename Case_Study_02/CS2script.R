########################## Case study 2 Script ########################
library(tidyverse)
library(gapminder)


gap <- as.tibble(gapminder)

gap %>%
  ggplot(aes(x = lifeExp, y = gdpPercap)) +
  geom_point(aes(color = continent, size = pop/100000)) +
  facet_grid(~year) +
  scale_y_continuous(trans = 'sqrt') +
  labs(x = 'Life Expectancy', y = 'GDP per capita', size = 'Population (100k)', color = 'Continent')



cont <- gap %>%
  group_by(continent, year) %>%
  summarise(wtavg = weighted.mean(gdpPercap, pop),
            pop = sum(as.numeric(pop)))

cont

gap %>%
  filter(country != "Kuwait") %>%
  ggplot(aes(x = year, y = gdpPercap)) +
  geom_point(aes(color = continent)) +
  geom_line(aes(group = country, color = continent)) +
  geom_point(data = cont, aes(x = year, y = wtavg, size = pop/100000), color = 'grey0') +
  geom_line(data = cont, aes(x = year, y = wtavg), color = 'grey0') +
  facet_grid(~continent) +
  labs(x = 'Year', y = 'GDP per capita', size = 'Population (100k)', color = 'Continent')

