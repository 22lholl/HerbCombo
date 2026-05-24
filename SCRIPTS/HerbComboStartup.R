#Lillian Holl
#HerbCombo - puts GEOG491 and ENSC381 projects in one place in prep for publication
#Startup
#5/18/2026

####Dataframes####

#SUWS WisFlora, unaltered
SUWS <- read.csv("RAW/occurrence_data_20250922105936_DarwinCore.csv")

#SUWS_clean
SUWS_clean <- read.csv("DATA/CLEAN/SUWS_clean.csv")

####Packages####

library(tidyverse)