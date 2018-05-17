library(dplyr)
library(ggplot2)
library(countrycode)

#data bases
http://www.oecd.org/dac/stats/idsonline.htm
https://www.gapminder.org/
  https://ourworldindata.org/homicides


mrdr <- read.csv(file = "wldmurdr.csv", header = TRUE)


m1 <- mrdr %>%
  mutate(cont = countrycode(mrdr$Entity, "country.name", "continent"))

View(m1)


m2 <- m1 %>%
  group_by(cont, Year) %>%
  summarise(c <- (mean(child)))
            


ggplot(m2, aes(Year, "mean(child)" = cont)) +
  geom_point()

ggplot(m1, aes(Year, infant, color = Entity)) +
  geom_point()


One of the most interesting things seen in the visualiztions is that homocide rates across the world on the the decline, one major exception is in one nation in Africa who will have to be determined by futher expoloratory analysis.



