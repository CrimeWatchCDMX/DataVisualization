library(tidyverse)

wal <- read_csv("https://byuistats.github.io/M335/data/Walmart_store_openings.csv")

w <- wal %>%
  separate(OPENDATE, into = c("day", "mnth", "yr"), sep = "/") %>%
  mutate(ST = as.factor(STRSTATE)) %>%
  mutate(state = fct_reorder(ST, yr, min))



region <- tibble(state = state.abb)

region


fct_reorder("STRSTATE", "yr", min, data = w)

w %>%
  ggplot(aes(yr)) +
  geom_bar() +
  facet_grid(STRSTATE ~.)+
  theme(
    axis.title.y=element_blank(),legend.position="none",
    axis.text.y=element_blank(),axis.ticks=element_blank()
)

  facet_grid(vars(STRSTATE)) 

table(wal$OPENDATE)

df %>%
  arrange(desc(sales))
