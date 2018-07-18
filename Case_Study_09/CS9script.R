################################# Case Study 9 #################################
library(tidyquant)
library(tidyverse)
library(dygraphs)
library(lubridate)
library(plotly)


tickers_today <- c("CXW", "F", "GM", "JCP", "KR", "WDC", "NKE","T", "WDAY", "WFC", "WMT")

quote <- tq_get(tickers_today, get = "stock.prices", from = "2013-06-26")

dyCXW <- quote %>%
  filter(symbol == "CXW") %>%
  select(date, adjusted)

dyF <- quote %>%
  filter(symbol == "F") %>%
  select(date, adjusted)

dyGM <- quote %>%
  filter(symbol == "GM") %>%
  select(date, adjusted)

dyJCP <- quote %>%
  filter(symbol == "JCP") %>%
  select(date, adjusted)


dyKR <- quote %>%
  filter(symbol == "KR") %>%
  select(date, adjusted)


dyWDC <- quote %>%
  filter(symbol == "WDC") %>%
  select(date, adjusted)


dyNKE <- quote %>%
  filter(symbol == "NKE") %>%
  select(date, adjusted)


dyT <- quote %>%
  filter(symbol == "T") %>%
  select(date, adjusted)


dyWDAY <- quote %>%
  filter(symbol == "WDAY") %>%
  select(date, adjusted)


dyWFC <- quote %>%
  filter(symbol == "WFC") %>%
  select(date, adjusted)


dyWMT <- quote %>%
  filter(symbol == "WMT") %>%
  select(date, adjusted)

CXW <- xts(dyCXW$adjusted, order.by = as.Date(dyCXW$date))

F <- xts(dyF$adjusted, order.by = as.Date(dyF$date))

GM <- xts(dyGM$adjusted, order.by = as.Date(dyGM$date))

JCP <- xts(dyJCP$adjusted, order.by = as.Date(dyJCP$date))

KR <- xts(dyKR$adjusted, order.by = as.Date(dyKR$date))

WDC <- xts(dyWDC$adjusted, order.by = as.Date(dyWDC$date))

NKE <- xts(dyNKE$adjusted, order.by = as.Date(dyNKE$date))

T <- xts(dyT$adjusted, order.by = as.Date(dyT$date))

WDAY <- xts(dyWDAY$adjusted, order.by = as.Date(dyWDAY$date))

WFC <- xts(dyWFC$adjusted, order.by = as.Date(dyWFC$date))

WMT <- xts(dyWMT$adjusted, order.by = as.Date(dyWMT$date))


dyquote <- cbind(CXW, F, GM, JCP, KR, WDC, NKE, T, WDAY, WFC, WMT)



dygraph(dyquote) %>%
  dySeries("..1", label = "CXW") %>%
  dySeries("..2", label = "F") %>%
  dySeries("..3", label = "GM") %>%
  dySeries("..4", label = "JCP") %>% 
  dySeries("..5", label = "KR") %>%
  dySeries("..6", label = "WDC") %>%
  dySeries("..7", label = "NKE") %>%
  dySeries("..8", label = "T") %>%
  dySeries("..9", label = "WDAY") %>%
  dySeries("..10", label = "WFC") %>%
  dySeries("..11", label = "WMT")




tidyquote <- quote %>%
  mutate(vol = volume/10000) %>%
  select(symbol, date, vol, adjusted)

tidyquote %>%
  ggplot(aes(x = symbol, y = vol, color = date, fill = symbol)) +
  geom_jitter() +
  geom_boxplot() +
  labs(y = 'Volume (tens of thousands of shares)', x = 'Ticker' )


tidyquote %>%
  ggplot(aes(x = date, y = vol, color = symbol)) +
  geom_point(aes(size = adjusted)) +
  facet_wrap(~symbol) +
  labs(y = 'Volume (tens of thousands of shares)', x = 'Date' )

