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
  ggplot(aes(x = as.double(hr), y = sales)) +
  geom_jitter() +
  facet_wrap(~Name) +
  coord_cartesian(ylim = 0:400, xlim = 06:24)

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
  geom_point(aes(color = Name)) +
  geom_smooth(aes(color = Name)) +
  facet_wrap(~Name) +
  labs(x = "Days of ")

monthly <- tz_fix %>%
  group_by(Name, mnth) %>%
  summarise(sales = sum(Amount))

monthly %>%
  filter(Name != "Missing") %>%
  ggplot(aes(x = mnth, y = sales, fill = sales)) +
  geom_bar(stat="identity") +
  facet_wrap(~Name)

