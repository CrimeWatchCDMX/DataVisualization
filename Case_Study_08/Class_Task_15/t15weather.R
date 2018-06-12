library(tidyverse)
library(reim)

wthrmn <- riem_measures(station = "RXE", date_start = "2015-06-01", date_end = "2017-07-01")


wthr <- wthrmn %>%
  mutate(wkday = weekdays(valid)) %>%
  separate(valid, into = c("yr", "mnth", "day"), sep = "-") %>%
  mutate(m = mnth) %>%
  filter(m == "06") %>%
  mutate(time = paste(yr, mnth, day, sep = "-")) %>%
  select(-one_of(c("mnth"))) 




wthr %>%
  ggplot(aes(x = wkday, y = tmpf, fill = wkday)) +
  geom_boxplot() +
  facet_wrap(~yr) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Day of the Week", y = "Daily Temperature Distribution in Fahrenheit")
  


wth <- wthrmn %>%
  mutate(wkday = weekdays(valid)) %>%
  separate(valid, into = c("yr", "mnth", "day"), sep = "-") %>%
  separate(day, into = c("day", "hr", sep = " ")) %>%
  mutate(hrr = paste(hr, ` `, sep = "")) %>%
  mutate(m = mnth) %>%
  filter(m == "06") %>%
  filter(between(as.double(hrr), 1300, 1500)) %>%
  mutate(time = paste(yr, mnth, day, sep = "-")) %>%
  select(-one_of(c("mnth", "hr", "metar")))

wth %>%
  ggplot(aes(x = wkday, y = tmpf, fill = wkday)) +
  geom_boxplot() +
  facet_wrap(~yr) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Day of the Week", y = "2:00 PM Temperature Distribution in Fahrenheit")

  


