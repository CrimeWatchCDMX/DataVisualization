library(nycflights13)
library(ggplot2)
library(dplyr)
library(tidyverse)

fl_bp <- flights %>%
  ggplot(aes(x = carrier, y = dep_delay))+
  coord_cartesian(,50:100,)+
  scale_y_continuous(breaks=seq(from=50,to=100,by=15))+
  labs(title="My fun plane plot", x="Airline", y="Delay")
fl_sc <- flights %>%
  filter(dep_time > 800, dep_time < 900) %>%
  ggplot(aes(x = dep_time, y = dep_delay))+
  coord_cartesian(,50:100,)+
  scale_color_brewer()
  labs(title="My fun plane plot", x="Departure", y="Delay")

fl_bp + geom_boxplot()
fl_sc + geom_point(aes(color = origin))+
  scale_color_calc()+
  theme_economist()+
  theme(legend.position="Bottom")


################################################

library(ggplot2)
library(gganimate)
library(gapminder)
theme_set(theme_bw())  # pre-set the bw theme.

g <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, frame = year)) +
  geom_point() +
  geom_smooth(aes(group = year), 
              method = "lm", 
              show.legend = FALSE) +
  facet_wrap(~continent, scales = "free") +
  scale_x_log10()  # convert to log scale

gganimate(g, interval=0.2)