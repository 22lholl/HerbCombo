#Lillian Holl
#GEOG 491
#HerbGIS - Workbench (any code scraps, current tasks, etc.)
#9/24/2025

SUWS_Brash_Aster <-
  SUWS_clean %>%
  filter(str_detect(recordedBy,
                    "Brashier"))

SUWS_December <-
  SUWS_clean %>%
  filter(month == "12")

SUWS_Abies <-
  SUWS_clean %>%
  filter(scientificName == "Abies balsamea")

#find date ranges for collectors

Coll_pst_sep_col <-
  SUWS_clean %>%
  select(catalogNumber,
         year,
         recordedBy) %>%
  separate(recordedBy,
           into = c('recordedBy_primary',
                    'recordedBy_secondary'),
           sep = ';') %>%
  separate(recordedBy_secondary,
           into = c('recordedBy_secondary_last',
                    'recordedBy_secondary_first',
                    'recordedBy_tertiary_last',
                    'recordedBy_tertiary_first'),
           sep = ",") %>%
  unite(col = recordedBy_secondary,
        recordedBy_secondary_last,
        recordedBy_secondary_first,
        sep = ',',
        na.rm = TRUE) %>%
  unite(col = recordedBy_tertiary,
        recordedBy_tertiary_last,
        recordedBy_tertiary_first,
        sep = ',',
        na.rm = TRUE)

#fix braashier - SUWS011985
Coll_pst_sep_col[Coll_pst_sep_col$catalogNumber == "SUWS011985", "recordedBy_secondary"] <- "Brashier"

Coll1 <-
  Coll_pst_sep_col %>%
  select(-recordedBy_secondary,
         -recordedBy_tertiary) %>%
  rename(collectedBy = recordedBy_primary)

Coll2 <-
  Coll_pst_sep_col %>%
  select(-recordedBy_primary,
         -recordedBy_tertiary) %>%
  filter(recordedBy_secondary != "") %>%
  rename(collectedBy = recordedBy_secondary)


Coll3 <-
  Coll_pst_sep_col %>%
  select(-recordedBy_secondary,
         -recordedBy_primary) %>%
  filter(recordedBy_tertiary != "") %>%
  rename(collectedBy = recordedBy_tertiary)

Coll_cty_CN <- rbind(Coll1,
                     Coll2,
                     Coll3)

#remove coll 1, coll2, coll3

rm(Coll1,
   Coll2,
   Coll3)

#trim collector column - somehow adding spaces before some names

Coll_cty_CN$collectedBy <-
  str_trim(Coll_cty_CN$collectedBy, side = "left")

#now find date ranges for collectors

date_range <-
  Coll_cty_CN %>%
  filter(collectedBy == "Thomson, John W., Jr.")






