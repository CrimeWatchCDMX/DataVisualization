library(readr)
library(dplyr)
library(stringi)
library(stringr)

bom <- read_csv("lds-scriptures.csv")

bmtxt <- bom %>%
  filter(volume_title == "Book of Mormon") %>%
  select(scripture_text)
  
  
nt_txt <- bom %>%
  filter(volume_title == "New Testament")%>%
  select(scripture_text)


ntst <- stri_stats_latex(nt_txt$scripture_text)
bmst <- stri_stats_latex(bmtxt$scripture_text)

dimnt <- dim(nt_txt)
dimbom <- dim(bmtxt)

ntavg <- ntst[[4]]/dimnt[[1]]
ntavg

bmavg <- bmst[[4]]/dimbom[[1]]
bmavg

ntavg/str_count(nt_txt, "Jesus")
bmavg/str_count(bmtxt, "Jesus")

nt_dist <- nt_txt %>%
  mutate(words = lengths(scripture_text))
nt_dist
  
bmdist

