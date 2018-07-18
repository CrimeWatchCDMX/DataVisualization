library(tidyverse)
library(nycflights13)


flghts <- flights

table(flights$carrier)

airlines

tots %>%
    ggplot(aes(x = carrier, y = total, fill = carrier)) +
  geom_bar(stat = 'identity')


wnames %>%
  ggplot(aes(x = dep_delay)) +
  geom_histogram(aes(y = stat(count), fill = stat(count))) +
  facet_wrap(~name) +
  geom_vline(aes(xintercept = median(dep_delay))) +
  coord_cartesian(xlim = -100:200) +
  scale_y_continuous(trans = 'sqrt') 
  




?carlist <- as.tibble(table(flights$carrier))

car <- carrier %>%
  rename('Var1' = "carrier")

fixlsit <- rename(carlist, carrier = Var1)
fixed <- rename(fixlsit, total = n)

tots <- inner_join(flghts, fixed, by = 'carrier')

wnames <- inner_join(tots, airlines, by = 'carrier')


flghts


wrdat <- tots %>%
  group_by(carrier) %>%
  summarize(total = mean(total))

