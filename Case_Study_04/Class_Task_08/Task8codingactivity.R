############################### Task 8 Class Coding Challenge ######################
library(readr)
library(dplyr)
library(ggplot2)

#Reading in the data
dat15 <- read_csv("https://query.data.world/s/uw2hhwji6dwz3637unq3twp7z4chl5")

#because dataset is huge, lets use random sample for plots
tdat <- dat15 %>%
  sample_n(100000) 

ggplot(tdat, aes(brthwt_g, fill = race)) +
  geom_histogram() +
  facet_wrap(~m_educ)


tdat %>%
  filter(!is.na(m_educ), m_educ != "None", !is.na(race), !is.na(marital_status), marital_status != "None") %>%
  ggplot(aes(marital_status, brthwt_g, color = race)) +
  geom_boxplot() +
  facet_wrap(~m_educ) +
  labs(y = "Birth Weight", x = "Marital Status")


tdat %>%
  filter(!is.na(gest_weeks), m_educ != "None", !is.na(race), !is.na(marital_status), marital_status != "None") %>%
  ggplot(aes(deliv_type)) +
  geom_bar()+
  scale_y_continuous()+
  facet_wrap(~gest_weeks)


