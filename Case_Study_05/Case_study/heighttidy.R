library(haven)
library(readxl)
library(readr)
library(tidyverse)

heightxl <- read_xlsx("Height.xlsx", skip = 1)

h <- heightxl %>%
  gather(year, height, '1800':'2011') %>%
  separate(year, into = c("dec", "yr"), sep = 3) %>%
  mutate(decade = as.numeric(dec)*10) %>%
  unite(year, dec, yr, sep = '') %>%
  na.omit()

us <- read_csv('https://github.com/hadley/r4ds/raw/master/data/heights.csv')


us
