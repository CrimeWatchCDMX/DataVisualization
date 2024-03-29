---
title: "The Great American Housing Crash"
author: "Erik McDonald"
date: "June 30, 2018"
output:
  html_document:  
    keep_md: true
    toc: true
    toc_float: true
    code_folding: hide
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
---






```r
buildings::permits
```

```
## # A tibble: 327,422 x 7
##    state StateAbbr county countyname     variable     year value
##    <int> <chr>      <int> <chr>          <chr>       <int> <int>
##  1     1 AL             1 Autauga County All Permits  2010   191
##  2     1 AL             1 Autauga County All Permits  2009   110
##  3     1 AL             1 Autauga County All Permits  2008   173
##  4     1 AL             1 Autauga County All Permits  2007   260
##  5     1 AL             1 Autauga County All Permits  2006   347
##  6     1 AL             1 Autauga County All Permits  2005   313
##  7     1 AL             1 Autauga County All Permits  2004   367
##  8     1 AL             1 Autauga County All Permits  2003   283
##  9     1 AL             1 Autauga County All Permits  2002   276
## 10     1 AL             1 Autauga County All Permits  2001   400
## # ... with 327,412 more rows
```

## Background

It is agreed that the Great Recession initially started to take its toll around late 2007 and throughout 2008. However to those who were paying attention, the signs could be seen well ahead of the onset of the crisis. In order to better understand how housing trends led up to the crisis we will take a look at percent change in housing starts across the US and in California from 1999 to 2010.

## Data Wrangling


```r
states <- us_states() %>%
  filter(state_abbr != "AK" & state_abbr != "PI" & state_abbr != "HI") %>%
  mutate(State = state_abbr)

ca_cont <- us_counties() %>%
  filter(state_abbr == "CA")


ca_perm <- permits %>%
  filter(variable == "Single Family" & StateAbbr == "CA") %>%
  mutate(name = str_sub(countyname, end = -8)) %>%
  group_by(name, year) %>%
  summarise(sum(value)) %>% 
  mutate(pct_change = (`sum(value)`/lag(`sum(value)`) - 1) * 100) %>%
  mutate(abr = "CA")



p <-  permits %>%
  filter(variable == "Single Family") %>%
  group_by(StateAbbr, year) %>%
  summarise(sum(value)) %>% 
  mutate(pct_change = (`sum(value)`/lag(`sum(value)`) - 1) * 100) %>%
  mutate(State = StateAbbr) %>%
  mutate(permits = `sum(value)`)


country_data <- inner_join(states, p, by = "State")

ca_data <- inner_join(ca_perm, ca_cont, by = "name")
```

## Data Visualization

The first visualization will examine the continental United States.

```r
country_data %>%
  filter(between(year, 1999,2010)) %>%
  filter(between(pct_change, -90, 100)) %>%
  ggplot() +
  geom_sf(aes(fill = pct_change)) +
  scale_fill_gradient2(low = "red", mid = "white",
                       high = "green", midpoint = 0,
                       na.value = "grey50") +
  facet_wrap(~year) +
  labs(fill = "Percent Change", title = "Trends in U.S. Housing Starts", subtitle = "(1999 - 2010)") +
  theme_bw() +
  theme(legend.position = "bottom")
```

![](cs10housing_files/figure-html/plot_data-1.png)<!-- -->

The next graphic takes a look at housing trends in the state of California by county throughout the same time period.


```r
ca_data %>%
  filter(between(year, 1999,2010)) %>%
  filter(between(pct_change, -90, 100)) %>%
  ggplot() +
  geom_sf(aes(fill = pct_change)) +
  scale_fill_gradient2(low = "red", mid = "white",
                       high = "green", midpoint = 0,
                       na.value = "grey50") +
  facet_wrap(~year) +
  labs(fill = "Percent Change", title = "Trends in CA Housing Starts", subtitle = "(1999 - 2010)") +
  theme_bw() +
  theme(legend.position = "bottom")
```

![](cs10housing_files/figure-html/unnamed-chunk-2-1.png)<!-- -->
