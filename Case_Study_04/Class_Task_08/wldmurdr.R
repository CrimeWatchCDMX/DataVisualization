library(dplyr)
library(ggplot2)
library(countrycode)
library(tidyr)
library(purrr)
library(broom)
library(readr)
library(ggthemes)

## databases for this and similar projects
# http://www.oecd.org/dac/stats/idsonline.htm
# https://www.gapminder.org/
# https://ourworldindata.org/homicides

## The dataset being used comes from ourworldindata.org and measures homicides per 100,000 across ages for the world
## The groupings for each age group are headed as std, old, mid, sen, child, all, infant.

mrdr <- read_csv(file = "wldmurdr.csv") #to access the data I set wd to source file location as I downloaded the .csv to same folder as script



#### creating vectors for areas of interest
NrthAm <- c("United States", "Canada")
DrgWar <- c("Mexico", "Guatemala", "Honduras", "El Salvador", "Colombia", "Venezuela", "Brazil")
Andes <- c("Colombia", "Venezuela", "Ecuador", "Peru", "Bolivia")
StableLatinAm <- c("Chile", "Argentina", "Uruguay", "Costa Rica")
MidEst <- c("Israel", "Saudi Arabia", "Iraq", "Syria", "Jordan", "Yemen", "Oman")
Maghreb <- c("Egypt", "Libya", "Algeria", "Tunisia", "Morocco", "Mali")




########################################### Data Transformations  #################################

by_country <- mrdr %>%
  mutate(Continent = countrycode(mrdr$Entity, "country.name", "continent")) #adding a continent column for futher analysis


cont_by_child <- by_country %>%
  group_by(Continent, Year) %>%
  summarise(rate = (mean(child))) #new dataframe where we can see the child homicide rate across continents

cont_by_child            

cont_by_all <- by_country %>%
  group_by(Continent, Year) %>%
  summarise(rate = (mean(all))) #new dataframe where we can total mean homicide rate across continents

by_country_lm <- by_country %>%
  nest(-Entity) %>%
  mutate(model = map(data, ~ lm(all ~ Year, data = .)),
         tidied = map(model, tidy)) %>%
  unnest(tidied)                #new dataframe where a linear model is attached to each country's total homicide rate



                

filtered_lm <- by_country_lm %>%
  mutate(p.adjusted = p.adjust(p.value)) %>%
  filter(p.adjusted < .05)      #new dataframe where only the countries with statistically signiciant trends in homicide rates are included

## To view slopes from lm dataframe use
filtered_lm %>%
  filter(term == "Year")

filtered_lm %>%
  filter(estimate > 0 & term == "Year") #this will indicate all the countries with a statiscally significant increase in homicide rates


###################### Sorting Data #############################

filtered_lm %>%
  filter(estimate > 0 & term == "Year")%>%
  arrange(desc(estimate)) #this command lists in order countries with the sharpest increases in homicides, interestingly most are carribean



filtered_lm %>%
  filter(estimate < 0 & term == "Year")%>%
  arrange(estimate) #list countries with the steepest decline in homicides since 1990, interestingly, many were countries behind the iron



################################ Visualizations ##################################

cont_by_all %>%
  filter(!is.na(Continent),) %>%
ggplot(aes(x = Year, y = rate, color = Continent)) +
  geom_point() +
  geom_smooth() + 
  labs(y = "Homocide Rate") + 
  theme_gdocs()            #Visualization for average homicide rate across continents


by_country %>%
  filter(Entity == StableLatinAm | Entity == DrgWar) %>%
  ggplot(aes(x = Entity, y = all, fill = Entity)) +
  geom_boxplot() +
  labs(y = "Homocide Rate") #Boxplots visualizating ditributions of total homicide rates since 1990



#The following visualizations follow the same format and can be manipulated by chaning the country or
#vectored region in the filter call, or modified by changing the specific homicide rate analyzed in aes call


by_country %>% 
  filter(Entity == NrthAm | Entity == StableLatinAm) %>%
    ggplot(aes(x = Year, y = child, color = Entity)) +
      geom_point() +
      geom_line() +
      labs(y = "Child Homicide Rate")  + 
      theme_gdocs()

by_country %>% 
  filter(Entity == NrthAm | Entity == StableLatinAm | Entity == DrgWar) %>%
    ggplot(aes(x = Year, y = infant, color = Entity)) +
      geom_point() +
      geom_line() +
      labs(y = "Infant Homicide Rate")  + 
      theme_gdocs()

by_country %>% 
  filter(Entity == "Colombia" | Entity == StableLatinAm | Entity == "Mexico") %>%
    ggplot(aes(x = Year, y = all, color = Entity)) +
      geom_point() +
      geom_line() +
      labs(y = "Total Homicide Rate")  + 
      theme_gdocs()



##################### code ideas ################################
by_country_year_topic <- votes_tidied %>%
  group_by(country, year, topic) %>%
  summarize(total = n(), percent_yes = mean(vote == 1)) %>%
  ungroup()


















