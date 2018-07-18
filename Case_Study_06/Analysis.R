devtools::install_github("hathawayj/buildings")

buildings_id <- as.tibble(buildings0809)

zone <- as.tibble(climate_zone_fips)

joined <- inner_join(buildings_id, zone, by = c("FIPS.state", "FIPS.county"))

View(joined)

restraunts <- joined %>%
  filter(Type == "Food_Beverage_Service")

table(restraunts$SqFt)

percent_food <- joined %>%
  group_by(County.x) %>%
  dplyr::summarise(total = n(),
                   percent_rest = mean(Type == "Food_Beverage_Service")) %>%
  arrange(desc(percent_rest))



table(percents$County.x)
percent_other
percent_other <- joined %>%
  group_by(County.x) %>%
  dplyr::summarise(total = n(),
                   percent_oth = mean(Type != "Food_Beverage_Service")) %>%
  arrange(desc(percent_oth))

percent_other %>%
  filter(percent_oth < 1) %>%
  ggplot(aes(x = fct_reorder(County.x, total), y = percent_oth, fill = total)) +
    geom_col()+
    theme(axis.text.x = element_text(angle = -45, hjust = 0)) +
    labs(x = "County", y = "Percent other establishments") +
    coord_cartesian(ylim = c(.75,1))


percent_othe <- percent_other %>%
fct_reorder(percent_other$County.x, percent_other$total)

library(forcats)
