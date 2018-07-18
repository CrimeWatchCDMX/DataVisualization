library(tidyverse)
library(lubridate)
library(riem)
library(readr)

read_csv()
read_xls()

wthr <- riem_measures(station = "RXE", date_start = "2016-05-13", date_end = "2016-07-08")

cars <- read_csv("https://byuistats.github.io/M335/data/carwash.csv")


car_ob <- cars %>%
  mutate(mtime = with_tz(time, tzone = "America/Denver")) %>%
  mutate(hr = ceiling_date(mtime, unit = "hours")) %>%
  group_by(hr) %>%
  summarise(sales = sum(amount))




wthr %>%
  filter(!is.na(tmpf)) %>%
  ggplot(aes(x = valid, y = tmpf)) +
    geom_point() +
    geom_smooth()


wth_ob <- wthr %>%
  filter(!is.na(tmpf)) %>%
  mutate(hr = ceiling_date(valid, unit = "hours")) %>%
  select(station:valid, tmpf, hr)  

df <- inner_join(car_ob, wth_ob, by = c("hr"))

df %>%
  ggplot(aes(x = tmpf, y = sales )) +
    geom_jitter() +
    geom_smooth()

df %>%
  ggplot(aes(x = hr, y = sales)) +
  geom_point()
