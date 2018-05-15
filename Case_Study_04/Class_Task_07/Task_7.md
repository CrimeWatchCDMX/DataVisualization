---
title: "Turn of the Century Child Mortality Rates"
author: "Erik McDonald"
date: "May 15, 2018"
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
library(ourworldindata)
library(dplyr)
library(ggplot2)

health1 <- subset(financing_healthcare, country != "Abkhazia" & year == 1995 | year == 2000 | year == 2005 | year == 2010)

ggplot(health1, aes(gdp, child_mort)) +
    geom_point(aes(size = health_exp_total, color = continent)) +
     facet_wrap(~year)
```

![](Task_7_files/figure-html/unnamed-chunk-2-1.png)<!-- -->
