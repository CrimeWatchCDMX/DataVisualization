library(tidyverse)
library(tidyquant)
library(dygraphs)
library(xts)
library(Quandl)
library(timetk)

kr <- tq_get("KR", get = "stock.price", from = "2013-01-01")

k <- kr %>%
  mutate(time = row_number()) %>%
  select(time, adjusted)

dygraph(k)


kt <- kr %>%
  mutate(dat = ts(date)) %>%
  mutate(d = tk_index(dat)) %>%
  mutate(dd = tk_ts(d))
