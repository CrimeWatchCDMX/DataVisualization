library(tidyquant)
library(tidyverse)

me <- c("FSLR", "TSLA", "NFLX") %>%
  tq_get(get  = "stock.prices",
         from = "2017-10-01") %>%
  group_by(symbol) 


frnd <- c("F", "GM", "CLD") %>%
  tq_get(get  = "stock.prices",
         from = "2017-10-01") %>%
  group_by(symbol) 

bet <- rbind(me, frnd)

bet <- bet %>%
  mutate(port = ifelse(grepl("FSLR", symbol),"mine",
                       ifelse(grepl("TSLA", symbol),"mine",
                              ifelse(grepl("NFLX", symbol),"mine", "his"))))


bet %>%
  filter(date == "2017-10-03")


mywts_map <- tibble(
  symbols = c("FSLR", "TSLA", "NFLX"),
  weights = c(1/3, 1/3, 1/3)
)

frndwts_map <- tibble(
  symbols = c("F", "GM", "CLD"),
  weights = c(0.333, 0.333, 0.333)
)


me %>%
  tq_portfolio(assets_col  = symbol, 
               returns_col = adjusted, 
               weights     =  mywts_map, 
               col_rename  = "Ra_using_wts_map")


myside <- bet %>%
  group_by(port, date) %>%
  filter(port == "mine") %>%
  summarise(val = sum(adjusted)) %>%
  mutate(totval = val *1.8)

hisside <- bet %>%
  group_by(port, date) %>%
  filter(port == "his") %>%
  summarise(val = sum(adjusted)) %>%
  mutate(totval = val *18)

tot_bet <- rbind(myside, hisside)

tot_bet %>%
  ggplot(aes(x = date, y = totval, color = port)) +
  geom_line()

bet %>%
  ggplot(aes(x = date, y = adjusted, color = symbol)) +
  geom_point(size = .1) +
  geom_line()
