# http://bradleyboehmke.github.io/2015/12/scraping-html-tables.html
library(XML)
library(RCurl)
library(tidyverse)
library(lubridate)
library(ggrepel)
library(downloader)


url_size <- "https://web.archive.org/web/20180301054455/https://ldschurchtemples.org/statistics/dimensions/"
url_time <- "https://web.archive.org/web/20171104095236/http://ldschurchtemples.org:80/statistics/timelines/"


dimensions <- url_size %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[1]] %>%
  as.tibble()

times_AnGrbr <- url_time %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[3]] %>%
  as.tibble() %>%
  select(-Duration)

times_GrbrDed <- url_time %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[4]] %>%
  as.tibble() %>%
  select(-Duration)


temples_joined <- inner_join(times_AnGrbr, times_GrbrDed, by = c('Temple', 'Ground Broken'))

dimensions_fix <- dimensions %>%
  rename(Temple = "Temple ")

temples <- inner_join(temples_joined, dimensions_fix, by = c("Temple"))

temples <- temples %>%
  mutate(Temple = gsub("Temple[â€¡]+", "Temple", Temple),
       Temple = iconv(Temple, from="UTF-8", to="LATIN1")) %>%
  separate()


dimensions$'Temple ' <- dimensions$'Temple ' %>%
      str_replace_all("[†‡]", "")

temples %>%
  ggplot(aes(Ground Broken, SquareFootage)) +
    geom_line()
