#############Task 5 script#############
library(tidyverse)
library(readxl)

setwd("C:/Users/Internacionale/Downloads")

data <- read_xlsx('388reg.xlsx')

data

#######poor plot

data %>%
  ggplot() +
  geom_line(aes(x = Date, y = spcc), color = 'red') +
  geom_line(aes(x = Date, y = sp), color = 'red') +
  geom_line(aes(x = Date, y = splp), color = 'red')


#######better plot

data %>%
  ggplot(aes(x = Date, y = sp, col = spcc)) +
  geom_line(size = .8) +
  scale_color_gradient2(low = 'red', high = 'green', mid = 'blue')+
  geom_line(data = data, mapping = aes(x = Date, y = splp/1000), color = 'black') +
  labs(y = 'Volume & Price Performance', col = "S&P 500 Returns", title = "S&P 500 Performance", subtitle = "Top: Closing Price in thousands \nBottom: Percent Change in Volume Traded")
