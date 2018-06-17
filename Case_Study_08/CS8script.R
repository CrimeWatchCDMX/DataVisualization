library(tidyverse)
library(lubridate)

data <- read_csv("https://byuistats.github.io/M335/data/sales.csv")

data_hrs <- data %>%
  mutate(Time = with_tz(Time, tzone = "America/Denver"))%>%
  mutate(Time = round_date(Time, unit = "hours")) %>%
  group_by(Name, Time) %>%
  summarise(sales = sum(Amount)) %>%
  separate(Time, into = c("yr", "mnth", "day"), sep = "-") %>%
  separate(day, into = c("hr", "min", "sec"), sep = ":") %>%
  separate(hr, into = c("day", "hr"), sep = " ") %>%
  mutate(Time = ymd_hms(paste(yr, mnth, day, hr, min, sec)))






tz_fix <- data %>%
  mutate(Time = with_tz(Time, tzone = "America/Denver"))%>%
  mutate(Time = round_date(Time, unit = "hours")) %>%
  separate(Time, into = c("yr", "mnth", "day"), sep = "-") %>%
  separate(day, into = c("hr", "min", "sec"), sep = ":") %>%
  separate(hr, into = c("day", "hr"), sep = " ") %>%
  mutate(Time = ymd_hms(paste(yr, mnth, day, hr, min, sec)))


hrs %>%
  filter(Name != "Missing") %>%
  ggplot(aes(x = hr, y = sales)) +
  geom_jitter() +
  facet_wrap(~Name) +
  coord_cartesian(ylim = 0:400)

hrs <- tz_fix %>%
  group_by(Name, Time, hr) %>%
  summarise(sales = sum(Amount))

daily <-  tz_fix %>%
  mutate(days = ymd(paste(yr, mnth, day))) %>%
  group_by(Name, days) %>%
  summarise(sales = sum(Amount))

daily %>%
  filter(Name != "Missing") %>%
  ggplot(aes(x = days, y = sales)) +
  geom_point(aes(color = Name) +
  geom_smooth(aes(color = Name)) +
  facet_wrap(~Name)

