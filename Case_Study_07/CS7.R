library(readr)
library(tidyverse)
library(stringi)
library(stringr)


scrip <- read_csv("lds-scriptures.csv")

bmtxt <- scrip %>%
  filter(volume_title == "Book of Mormon")

bm_strng <- scrip %>%
  filter(volume_title == "Book of Mormon") %>%
  str_c(collapse = " ")

names <- read_rds(gzcon(url("https://byuistats.github.io/M335/data/BoM_SaviorNames.rds")))

list <- as.vector(names$name)
list <- str_c(list, collapse = "|")


str_locate_all(bm_strng, list)
