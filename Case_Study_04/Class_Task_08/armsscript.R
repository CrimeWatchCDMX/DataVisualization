library(tidyverse)
library(countrycode)
library(readxl)
library(plyr)
library(dplyr)
library(dygraphs)

arms <- read_xlsx("Arms imports.xlsx")

NrthAm <- c("United States", "Canada")
DrgWar <- c("Mexico", "Guatemala", "Honduras", "El Salvador", "Colombia", "Venezuela", "Brazil")
Andes <- c("Colombia", "Venezuela", "Ecuador", "Peru", "Bolivia")
StableLatinAm <- c("Chile", "Argentina", "Uruguay", "Costa Rica")
MidEst <- c("Israel", "Saudi Arabia", "Iraq", "Syria", "Jordan", "Yemen", "Oman")
Maghreb <- c("Egypt", "Libya", "Algeria", "Tunisia", "Morocco", "Mali")



import <- imports <- arms %>%
  gather(year, imports, '1960':'2011')

imports <- rename(import, c('Arms imports (constant 1990 US$)'='country'))


fin %>%
  filter(between(year, 1960, 1989)) %>%
  filter(country == DrgWar | country == "Costa Rica" | country == "Nicaragua"| country == "Argentina"| country == "Chile") %>%
  filter(!is.na(imports)) %>%
  ggplot(aes(x = country, y = percap, fill = country)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_cartesian(ylim = 0:30)

imports %>%
  filter(country == "Israel")



imports <- imports %>%
  mutate(in_tens_thousands = imports/10000)


pop <- read_csv("wldpop.csv", skip = 4)

pop <- pop %>%
  gather(year, pop, '1960':'2016') %>%
  mutate(country = `Country Name`)

full_dat <- inner_join(imports, pop, by = c("country", "year"))

fin <- full_dat %>%
  mutate(percap = imports/pop) %>%
  mutate(percap_thou = percap/1000) %>%
  select(country, year, imports, in_tens_thousands, pop, percap, percap_thou) %>%
  mutate(year = as.double(year))


fin %>%
  filter(country == "Argentina" | country == "Colombia") %>%
  select(year, percap, country) %>%
  dygraph() %>%
    dySeries("country")

ar <- fin %>%
  filter(country == "Argentina") %>%
  select(year, percap, country)

ch <- fin %>%
  filter(country == "Chile") %>%
  select(percap, country)

dyarms <- cbind(ar, ch)

d <- dyarms %>%
  select(year, percap)

dygraph(dyarms)
