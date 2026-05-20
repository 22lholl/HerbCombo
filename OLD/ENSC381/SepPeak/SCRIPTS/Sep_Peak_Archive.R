#Lillian Holl
#ENSC 381
#Final Project - September Peak
#Archive
#Script started 3/11/2026

####Dataframes####

#SUWS WisFlora, unaltered
SUWS <- read.csv("RAW/occurrence_data_20250922105936_DarwinCore.csv")

#SUWS WisFlora, cleaned
SUWS_clean <- read.csv("CLEAN/SUWS_clean.csv")

#Coll_pst_sep_col - has catalogNumber as well as primary, secondary, and tertiary collector's names in separate columns
Coll_pst_sep_col <- read.csv("CLEAN/Coll_pst_sep_col.csv")

#SUWS where only primary collectors are attached to a record (single entry for a specimen)
SUWS_primary <- read.csv("CLEAN/SUWS_primary.csv")

#SUWS where collectors are associated with their record (specimens appear more than once if there was more than one collector)
SUWS_sep_collectors <- read.csv("CLEAN/SUWS_sep_collectors.csv")

#SUWS containing only those who have made contributions in September
SUWS_Sept_coll <- read.csv("CLEAN/SUWS_Sept_coll.csv")

#PLSS
PLSS <- read.csv("RAW/PLSS_Townships_1983HARN_TableToExcel.xlsx - PLSS_Townships_1983HARN.csv")

####Packages####

library(tidyverse)

#for graphing the histos? can't figure which function/argument it is...

library(scales)

#for modality

library(diptest)
library(LaplacesDemon)
library(mousetrap)

####SUWS to SUWS_clean - column and row clean-up####

#SUWS WisFlora, unaltered
SUWS <- read.csv("RAW/occurrence_data_20250922105936_DarwinCore.csv")

#Task - Clean Data
#want to get rid of extraneous columns from raw data

#checking if all NAs in a column - should have NA equal to the total number of records

SUWS %>% count(ownerInstitutionCode,
               institutionID,
               datasetID,
               otherCatalogNumbers,
               kingdom,
               phylum,
               identificationReferences,
               identificationRemarks,
               taxonRemarks,
               typeStatus,
               endDayOfYear,
               fieldNumber,
               fieldNotes,
               samplingProtocol,
               samplingEffort,
               eventID,
               dataGeneralizations,
               associatedOccurrences,
               associatedTaxa,
               reproductiveCondition,
               establishmentMeans,
               lifeStage,
               sex,
               behavior,
               individualCount,
               preparations,
               locationID,
               waterBody,
               municipality,
               locationRemarks,
               coordinatePrecision,
               verbatimCoordinateSystem,
               georeferencedBy,
               georeferenceVerificationStatus,
               maximumElevationInMeters,
               minimumDepthInMeters,
               maximumDepthInMeters,
               verbatimDepth,
               disposition,
               language,
               rightsHolder,
               accessRights,
               footprintWKT)

#putting all columns that are all NAs into list for ease of coding

NA_col <- c('ownerInstitutionCode',
            'institutionID',
            'datasetID',
            'otherCatalogNumbers',
            'kingdom',
            'phylum',
            'identificationReferences',
            'identificationRemarks',
            'taxonRemarks',
            'typeStatus',
            'endDayOfYear',
            'fieldNumber',
            'fieldNotes',
            'samplingProtocol',
            'samplingEffort',
            'eventID',
            'dataGeneralizations',
            'associatedOccurrences',
            'associatedTaxa',
            'reproductiveCondition',
            'establishmentMeans',
            'lifeStage',
            'sex',
            'behavior',
            'individualCount',
            'preparations',
            'locationID',
            'waterBody',
            'municipality',
            'locationRemarks',
            'coordinatePrecision',
            'verbatimCoordinateSystem',
            'georeferencedBy',
            'georeferenceVerificationStatus',
            'maximumElevationInMeters',
            'minimumDepthInMeters',
            'maximumDepthInMeters',
            'verbatimDepth',
            'disposition',
            'language',
            'rightsHolder',
            'accessRights',
            'footprintWKT')

#checking if all same entry in a column - should have number equal to the total number of records

SUWS %>% count(institutionCode,
               collectionCode,
               collectionID,
               basisOfRecord,
               country,
               stateProvince,
               rights)

#putting all columns that are all same entry into list for ease of coding

Rep_col <- c('institutionCode',
             'collectionCode',
             'collectionID',
             'basisOfRecord',
             'country',
             'stateProvince',
             'rights')

#This following lists column names that presently have information of little value to the purpose of the data during analysis so that they can be removed later

Misc_col <- c('occurrenceID',
              'id',
              'identificationQualifier',
              'modified',
              'rights',
              'references',
              'recordId',
              'dynamicProperties')

#fix to duplicate catalogNumbers

#the following lists the catalogNumber associated with two specimen records

DUP_CN <- c("SUWS017400",
            "SUWS017401",
            "SUWS017404",
            "SUWS017409",
            "SUWS017424",
            "SUWS017425",
            "SUWS017438",
            "SUWS017439",
            "SUWS017442",
            "SUWS017443",
            "SUWS017444",
            "SUWS017445",
            "SUWS017447",
            "SUWS017452",
            "SUWS017507",
            "SUWS017540",
            "SUWS017541",
            "SUWS017546",
            "SUWS017548",
            "SUWS017550",
            "SUWS017551",
            "SUWS017554",
            "SUWS017543",
            "SUWS017431",
            "SUWS017430",
            "SUWS017450",
            "SUWS017410",
            "SUWS017403",
            "SUWS017451",
            "SUWS017416",
            "SUWS017552")

#lists id of duplicates that were verified

VER_DUP_CN_id <- c("588982",
                   "588987",
                   "593874",
                   "593875",
                   "593886",
                   "593887",
                   "593890",
                   "593891",
                   "588973",
                   "593893",
                   "588972",
                   "593900",
                   "588978",
                   "588988",
                   "588983",
                   "588968",
                   "593973",
                   "593975",
                   "588977",
                   "588986",
                   "594250",
                   "594251",
                   "594252",
                   "594253",
                   "594254",
                   "593899",
                   "593866",
                   "594258")

#table that pulls out all duplicate records and keeps only the specified ones
#have been double checked against physical sheets, except for 017400, 017401, and 017403, which were not found
NOT_VER_DUP_CN_tbl <-
  SUWS %>%
  filter(catalogNumber %in% DUP_CN) %>%
  filter(!(id %in% VER_DUP_CN_id)) %>%
  select(id)

#creates dataset that has had all extraneous columns removed, includes fix to duplicate catalogNumber

SUWS_clean <- 
  anti_join(SUWS,
            NOT_VER_DUP_CN_tbl,
            by = "id") %>%
  select(-all_of(NA_col),
         -all_of(Rep_col),
         -all_of(Misc_col))

#fix braashier - SUWS011985
SUWS_clean[SUWS_clean$catalogNumber == "SUWS011985", "recordedBy"] <- "Holden; Brashier"

#save SUWS_clean

write.csv(SUWS_clean,
          file = "CLEAN/SUWS_clean.csv",
          row.names = FALSE)

#removes extraneous data and values from environment

rm(list = setdiff(ls(), "SUWS_clean"))

####Task: adding month as factor, remove NA months####

#filter out NAs from date columns
#in some cases, dates may be noted in record number or habitat column, could also get estimate based on when collector active? in any case, not enough consistency to be able to extract with code, and would be a hand edit

#see how many records will be removed

SUWS_clean %>% count(month)

SUWS_clean <-
  SUWS_clean %>% 
  filter(!(is.na(month)))

#make factor level variable for months

SUWS_clean <-
  SUWS_clean %>%
  mutate(month_fctr = case_when(
    month == "1" ~ "January",
    month == "2" ~ "February",
    month == "3" ~ "March",
    month == "4" ~ "April",
    month == "5" ~ "May",
    month == "6" ~ "June",
    month == "7" ~ "July",
    month == "8" ~ "August",
    month == "9" ~ "September",
    month == "10" ~ "October",
    month == "11" ~ "November",
    month == "12" ~ "December",
    TRUE ~ "Other Months"
  ))

#order factors

SUWS_clean$month_fctr <-
  factor(SUWS_clean$month_fctr,
         levels = c("January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December",
                    "Other Months"))

####Task: only attach primary to record####

SUWS_primary <-
  SUWS_clean %>%
  mutate(recordedBy_og = recordedBy) %>%
  separate(recordedBy,
           into = c('recordedBy_primary',
                    'recordedBy_secondary'),
           sep = ';') %>%
  select(-recordedBy_secondary)

#make collector group

SUWS_primary <-
  SUWS_primary %>%
  mutate(coll_gr = case_when(
    recordedBy_primary == "Brashier" ~ "Brashier",
    recordedBy_primary == "Thomson, John W., Jr." ~ "Thomson, John W., Jr.",
    recordedBy_primary == "Anderson, Derek S." ~ "Anderson, Derek S.",
    recordedBy_primary == "Koch, Rudy G." ~ "Koch, Rudy G.",
    recordedBy_primary == "Castle, R." ~ "Castle, R.",
    recordedBy_primary == "Romans" ~ "Romans",
    recordedBy_primary == "Davidson, Donald W." ~ "Davidson, Donald W.",
    TRUE ~ "Other Collectors" #Default Case
  )) 

#order factors for plot legend

SUWS_primary$coll_gr <-
  factor(SUWS_primary$coll_gr,
         levels = c("Anderson, Derek S.",
                    "Brashier",
                    "Castle, R.",
                    "Davidson, Donald W.",
                    "Koch, Rudy G.",
                    "Romans",
                    "Thomson, John W., Jr.",
                    "Other Collectors"))

####Task: attach primary, secondary, tertiary collectors to each record all in one column####

SUWS_sep_collectors <-
  SUWS_clean %>%
  mutate(recordedBy_og = recordedBy) %>%
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

#separate collectors

Coll1 <-
  SUWS_sep_collectors %>%
  select(-recordedBy_secondary,
         -recordedBy_tertiary) %>%
  rename(collectedBy = recordedBy_primary)

Coll2 <-
  SUWS_sep_collectors %>%
  select(-recordedBy_primary,
         -recordedBy_tertiary) %>%
  filter(recordedBy_secondary != "") %>%
  rename(collectedBy = recordedBy_secondary)


Coll3 <-
  SUWS_sep_collectors %>%
  select(-recordedBy_secondary,
         -recordedBy_primary) %>%
  filter(recordedBy_tertiary != "") %>%
  rename(collectedBy = recordedBy_tertiary)

SUWS_sep_collectors <- rbind(Coll1,
                             Coll2,
                             Coll3)

#remove coll 1, coll2, coll3

rm(Coll1,
   Coll2,
   Coll3)

#trim collector column - somehow adding spaces before some names

SUWS_sep_collectors$collectedBy <-
  str_trim(SUWS_sep_collectors$collectedBy, side = "left")

#make collector group

SUWS_sep_collectors <-
  SUWS_sep_collectors %>%
  mutate(coll_gr = case_when(
    collectedBy == "Brashier" ~ "Brashier",
    collectedBy == "Thomson, John W., Jr." ~ "Thomson, John W., Jr.",
    collectedBy == "Anderson, Derek S." ~ "Anderson, Derek S.",
    collectedBy == "Koch, Rudy G." ~ "Koch, Rudy G.",
    collectedBy == "Castle, R." ~ "Castle, R.",
    collectedBy == "Romans" ~ "Romans",
    collectedBy == "Davidson, Donald W." ~ "Davidson, Donald W.",
    TRUE ~ "Other Collectors" #Default Case
  )) 

#order factors for plot legend

SUWS_sep_collectors$coll_gr <-
  factor(SUWS_sep_collectors$coll_gr,
         levels = c("Anderson, Derek S.",
                    "Brashier",
                    "Castle, R.",
                    "Davidson, Donald W.",
                    "Koch, Rudy G.",
                    "Romans",
                    "Thomson, John W., Jr.",
                    "Other Collectors"))

####Task: save SUWS_primary and SUWS_sep_collectors as csv####

write.csv(SUWS_primary,
          file = "CLEAN/SUWS_primary.csv",
          row.names = FALSE)

write.csv(SUWS_sep_collectors,
          file = "CLEAN/SUWS_sep_collectors.csv",
          row.names = FALSE)

####Task: Remake monthly histo####

#order factors for x axis

SUWS_primary$month_fctr <-
  factor(SUWS_primary$month_fctr,
         levels = c("January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December",
                    "Other Months"))

SUWS_sep_collectors$month_fctr <-
  factor(SUWS_sep_collectors$month_fctr,
         levels = c("January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December",
                    "Other Months"))

#blank monthly histo - raw specimens numbers

ggplot(SUWS_primary,
       aes(x = month_fctr)) +
  geom_bar() +
  labs(title = "Specimens by Month",
       y = "Specimens") +
  theme(
    axis.title.x = element_blank(),
    axis.text.x = element_text(angle = 45,
                               hjust = 1,
                               vjust = 0.75)) +
  geom_text(aes(label = ..count..), stat = "count", vjust = 1, colour = "white")

#blank monthly histo - collection instances

ggplot(SUWS_sep_collectors,
       aes(x = month_fctr)) +
  geom_bar() +
  labs(title = "Contributions by Month",
       y = "Contributions") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   vjust = 0.75)) +
  geom_text(aes(label = ..count..), stat = "count", vjust = 1, colour = "white")

#order factors for plot legend

SUWS_primary$coll_gr <-
  factor(SUWS_primary$coll_gr,
         levels = c("Anderson, Derek S.",
                    "Brashier",
                    "Castle, R.",
                    "Davidson, Donald W.",
                    "Koch, Rudy G.",
                    "Romans",
                    "Thomson, John W., Jr.",
                    "Other Collectors"))

SUWS_sep_collectors$coll_gr <-
  factor(SUWS_sep_collectors$coll_gr,
         levels = c("Anderson, Derek S.",
                    "Brashier",
                    "Castle, R.",
                    "Davidson, Donald W.",
                    "Koch, Rudy G.",
                    "Romans",
                    "Thomson, John W., Jr.",
                    "Other Collectors"))

#monthly histo by primary contributor - raw specimen numbers

ggplot(SUWS_primary,
       aes(x = month_fctr,
           fill = coll_gr)) +
  geom_bar() +
  labs(title = "Specimens by Month",
       y = "Specimens",
       fill = "Primary Collector") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   vjust = 1)) +
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 1500), expand = c(0, 0)) +
  annotate("text",
           x = 1,
           y = 73,
           label = "28") +
  annotate("text",
           x = 2,
           y = 84,
           label = "39") +
  annotate("text",
           x = 3,
           y = 59,
           label = "14") +
  annotate("text",
           x = 4,
           y = 100,
           label = "55") +
  annotate("text",
           x = 5,
           y = 440,
           label = "395") +
  annotate("text",
           x = 5.90,
           y = 1085,
           label = "1040") +
  annotate("text",
           x = 7,
           y = 1447,
           label = "1402") +
  annotate("text",
           x = 8,
           y = 730,
           label = "685") +
  annotate("text",
           x = 9,
           y = 1164,
           label = "1119") +
  annotate("text",
           x = 10,
           y = 316,
           label = "271") +
  annotate("text",
           x = 11,
           y = 90,
           label = "45") +
  annotate("text",
           x = 12,
           y = 51,
           label = "6")

ggsave("PLOTS/Monthly_Specimens.png",
       height = 4,
       width = 6,
       units = "in",
       dpi = "retina")

#monthly histo by collector - collection instances

ggplot(SUWS_sep_collectors,
       aes(x = month_fctr,
           fill = coll_gr)) +
  geom_bar() +
  labs(title = "Contributions by Month",
       y = "Contributions",
       fill = "Contributor") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   vjust = 1)) +
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 2200), expand = c(0, 0)) +
  annotate("text",
           x = 1,
           y = 88,
           label = "33") +
  annotate("text",
           x = 2,
           y = 94,
           label = "39") +
  annotate("text",
           x = 3,
           y = 69,
           label = "14") +
  annotate("text",
           x = 4,
           y = 110,
           label = "55") +
  annotate("text",
           x = 5,
           y = 488,
           label = "433") +
  annotate("text",
           x = 5.9,
           y = 1417,
           label = "1362") +
  annotate("text",
           x = 7,
           y = 2096,
           label = "2041") +
  annotate("text",
           x = 8,
           y = 908,
           label = "853") +
  annotate("text",
           x = 9,
           y = 1211,
           label = "1156") +
  annotate("text",
           x = 10,
           y = 336,
           label = "281") +
  annotate("text",
           x = 11,
           y = 110,
           label = "55") +
  annotate("text",
           x = 12,
           y = 61,
           label = "6")

ggsave("PLOTS/Monthly_Contributions.png",
       height = 4,
       width = 6,
       units = "in",
       dpi = "retina")

####Task: make daily histo####

#blank monthly histo - raw specimens numbers

ggplot(SUWS_primary,
       aes(x = startDayOfYear)) +
  geom_bar() +
  annotate("text",
           label = "September",
           x = 325,
           y = 125,
           color = "red") +
  geom_vline(xintercept = 244,
             col = "red",
             size = 1) +
  geom_vline(xintercept = 273,
             col = "red",
             size = 1) +
  annotate("text",
           label = "July",
           x = 150,
           y = 125,
           color = "blue") +
  geom_vline(xintercept = 182,
             col = "blue",
             size = 1) +
  geom_vline(xintercept = 212,
             col = "blue",
             size = 1) +
  labs(title = "Specimens by Day",
       y = "Specimens") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

#blank monthly histo - collection instances

ggplot(SUWS_sep_collectors,
       aes(x = startDayOfYear)) +
  geom_bar() +
  annotate("text",
           label = "September",
           x = 325,
           y = 125,
           color = "red") +
  geom_vline(xintercept = 244,
             col = "red",
             size = 1) +
  geom_vline(xintercept = 273,
             col = "red",
             size = 1) +
  annotate("text",
           label = "July",
           x = 150,
           y = 125,
           color = "blue") +
  geom_vline(xintercept = 182,
             col = "blue",
             size = 1) +
  geom_vline(xintercept = 212,
             col = "blue",
             size = 1) +
  labs(title = "Contributions by Day",
       y = "Contributions") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

####Task: Modality tests on monthly graphs####

library(diptest)
library(LaplacesDemon)
library(mousetrap)

#monthly - raw specimen

dip.test(SUWS_primary$month)

is.unimodal(SUWS_primary$month)

is.multimodal(SUWS_primary$month)

is.bimodal(SUWS_primary$month)

bimodality_coefficient(SUWS_primary$month)

#monthly - contributions

dip.test(SUWS_sep_collectors$month)

is.unimodal(SUWS_sep_collectors$month)

is.multimodal(SUWS_sep_collectors$month)

is.bimodal(SUWS_sep_collectors$month)

bimodality_coefficient(SUWS_sep_collectors$month)

####BREAK####

####Task: pulling out September collectors####

#using SUWS_sep_coll

#how many people beforehand? 287

unique(SUWS_sep_collectors$collectedBy)

#process would be to pull out any records specifically from September, then grab those collectors names, then filter original dataset by those names to include their collections that hadn't been made in September

#pull records from September and grab unique collector names

Sep_coll <- unique(SUWS_sep_collectors$collectedBy[SUWS_sep_collectors$month == 9])

#123 people have collected in September

#filter SUWS_sep_collectors by names in Sep_coll

SUWS_Sept_coll <-
  SUWS_sep_collectors %>%
  filter(collectedBy %in% Sep_coll)

#save dataset

write.csv(SUWS_Sept_coll,
          file = "CLEAN/SUWS_Sept_coll.csv",
          row.names = FALSE)

####Task: Display the collection size of September collectors####

Sept_Coll_size <-
  SUWS_Sept_coll %>%
  group_by(collectedBy) %>%
  count(collectedBy)

#blank plot with all 123 collectors and their contributions

ggplot(Sept_Coll_size,
       aes(x = fct_reorder(collectedBy,
                           -n),
           y = n)) +
  geom_col() +
  labs(x = "Collectors (123)",
       y = "Contributions") +
  theme(axis.text.x = element_blank())

#plot annotating where ~50% of contributions are

#5 of top 7 - ~51%
#bottom 116 - ~49%

ggplot(Sept_Coll_size,
       aes(x = fct_reorder(collectedBy,
                           -n),
           y = n)) +
  geom_col() +
  geom_vline (xintercept = 5.5,
              color = "red",
              size = 1) +
  labs(x = "Collectors (123)",
       y = "Contributions") +
  theme(axis.text.x = element_blank())

#know that 5 of top 7 are in graph

ggplot(subset(Sept_Coll_size,
              n > 150),
       aes(x = fct_reorder(collectedBy,
                           -n),
           y = n)) +
  geom_col()  +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   vjust = 0.75))

#what about other collectors who also contributed during Sep?

ggplot(subset(Sept_Coll_size,
              n < 150),
       aes(x = fct_reorder(collectedBy,
                           -n),
           y = n)) +
  geom_col()  +
  labs(x = "Collectors (116), n < 150",
       y = "Contributions") + 
  theme(axis.text.x = element_blank())

####Task: Get temporal distribution of sep col####

#order factors for x axis

SUWS_Sept_coll$month_fctr <-
  factor(SUWS_Sept_coll$month_fctr,
         levels = c("January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December",
                    "Other Months"))

#make plots

#5 people (part of top 7) make up 50% of Sept contributors

ggplot(subset(SUWS_Sept_coll,
              coll_gr != "Other Collectors"),
       aes(x = month_fctr,
           fill = coll_gr)) +
  geom_vline(xintercept = 7,
             color = "red",
             size = 1) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 225), expand = c(0, 0)) +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 75,
                                   hjust = 1,
                                   vjust = 1),
        legend.position = "none") +
  facet_wrap(~ coll_gr) +
  labs(y = "Contributions")

ggsave("PLOTS/Sept_Coll_Size_t5_overall_highlight.png",
       height = 4,
       width = 6,
       units = "in",
       dpi = 320)

####Task: graph of only sep collections sizes####

only_Sept_Coll_size <-
  SUWS_Sept_coll %>%
  filter(month == 9) %>%
  group_by(collectedBy) %>%
  count(collectedBy)

ggplot(only_Sept_Coll_size,
       aes(x = fct_reorder(collectedBy,
                           -n),
           y = n)) +
  geom_col() +
  geom_vline (xintercept = 18.5,
              color = "red",
              size = 1) +
  labs(x = "Collectors (123)",
       y = "Contributions") +
  scale_y_continuous(limits = c(0, 70), expand = c(0, 0)) +
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank()) +
  annotate("text",
           x = 10,
           y = 60,
           label = "50.3%") +
  annotate("text",
           x = 70.5,
           y = 60,
           label = "49.7%")

ggsave("PLOTS/Sept_Coll_Size.png",
       height = 4,
       width = 6,
       units = "in",
       dpi = 320)

####Task: graph top 18 collectors in sept####

ggplot(subset(only_Sept_Coll_size,
              n > 21),
       aes(x = fct_reorder(collectedBy,
                           -n),
           y = n)) +
  geom_col()  +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 60,
                                   hjust = 1,
                                   vjust = 1)) +
  scale_y_continuous(limits = c(0, 75), expand = c(0, 0)) +
  labs(y = "Contributions")

ggsave("PLOTS/Sept_Coll_Size_t18.png",
       height = 4,
       width = 7.5,
       units = "in",
       dpi = 320)

####BREAK####
####Task: adding plant families and classifying by flowering or nonflowering####

#list angiosperm orders - according to APG IV 2016

Angio_list <- c("Amborellales",
                "Nymphaeales",
                "Austrobaileyales",
                "Magnoliales",
                "Laurales",
                "Piperales",
                "Canellales",
                "Chloranthales",
                "Arecales",
                "Poales",
                "Commelinales",
                "Zingiberales",
                "Asparagales",
                "Liliales",
                "Dioscoreales",
                "Pandanales",
                "Petrosaviables",
                "Alismatales",
                "Acorales",
                "Ceratophyllales",
                "Ranunculales",
                "Proteales",
                "Trochodendrales",
                "Buxales",
                "Gunnerales",
                "Fabales",
                "Rosales",
                "Fagales",
                "Cucurbitales",
                "Oxalidales",
                "Malpighiales",
                "Celastrales",
                "Zygophyllales",
                "Geraniales",
                "Myrtales",
                "Crossosomatales",
                "Picramniales",
                "Malvales",
                "Brassicales",
                "Huerteales",
                "Sapindales",
                "Vitales",
                "Saxifragales",
                "Dilleniales",
                "Berberidopsidales",
                "Santalales",
                "Caryophyllales",
                "Cornales",
                "Ericales",
                "Aquifoliales",
                "Asterales",
                "Escalloniales",
                "Bruniales",
                "Apiales",
                "Dipsacales",
                "Paracryphinales",
                "Solanales",
                "Lamiales",
                "Vahliales",
                "Gentianales",
                "Boraginales",
                "Garryales",
                "Metteniusales",
                "Icacinales")

#add column classifying whether collection is an angiosperm or not

SUWS_sep_collectors$Angio <-
  ifelse(SUWS_sep_collectors$order %in% Angio_list,
         "Angiosperms",
         "Nonflowering")

####Task: Bar chart for July vs. Sept collections, sep by Angio####

what_barchart <-
  SUWS_sep_collectors %>%
  filter(month_fctr == "July" |
           month_fctr == "September")

#order factors for plot legend

what_barchart$coll_gr <-
  factor(what_barchart$coll_gr,
         levels = c("Anderson, Derek S.",
                    "Brashier",
                    "Castle, R.",
                    "Davidson, Donald W.",
                    "Koch, Rudy G.",
                    "Romans",
                    "Thomson, John W., Jr.",
                    "Other Collectors"))  

#plot

ggplot(what_barchart,
       aes(x = Angio,
           fill = coll_gr)) +
  geom_bar() +
  facet_wrap(~ month_fctr)  +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   vjust = 1),
        legend.position = c(0.625, 0.75)) +
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 2000), expand = c(0, 0)) +
  labs(y = "Contributions",
       fill = "Contributor")

ggsave("PLOTS/July_Sept_Angio.png",
       height = 6,
       width = 3.5,
       units = "in",
       dpi = "retina")

####Task: Prep data for Paired Wilcox, assess for normality, Plot comparisons####

#filter for only July and Sep collections, then count by collector, month, and whether angiosperm order, then count

what_coll_count_month <-
  SUWS_sep_collectors %>%
  filter(month_fctr == "July" |
           month_fctr == "September") %>%
  group_by(collectedBy,
           coll_gr,
           month_fctr) %>%
  count(collectedBy) %>%
  pivot_wider(names_from = "month_fctr",
              values_from = "n")

what_coll_count_Angio <-
  SUWS_sep_collectors  %>%
  filter(month_fctr == "July" |
           month_fctr == "September") %>%
  group_by(collectedBy,
           coll_gr,
           Angio) %>%
  count(collectedBy) %>%
  pivot_wider(names_from = "Angio",
              values_from = "n")

what_coll_count <- 
  merge(what_coll_count_month,
        what_coll_count_Angio,
        by = c("collectedBy",
               "coll_gr")) %>%
  mutate(July = replace_na(July, 0),
         September = replace_na(September, 0),
         Angiosperms = replace_na(Angiosperms, 0),
         Nonflowering = replace_na(Nonflowering, 0)) %>%
  mutate(total = July + September)

#normality

qqnorm(what_coll_count$July)
qqline(what_coll_count$July,
       lty = 2)

qqnorm(what_coll_count$September)
qqline(what_coll_count$September,
       lty = 2)

qqnorm(what_coll_count$Angiosperms)
qqline(what_coll_count$Angiosperms,
       lty = 2)

qqnorm(what_coll_count$Nonflowering)
qqline(what_coll_count$Nonflowering,
       lty = 2)

#order factors for plot legend

what_coll_count$coll_gr <-
  factor(what_coll_count$coll_gr,
         levels = c("Anderson, Derek S.",
                    "Brashier",
                    "Castle, R.",
                    "Davidson, Donald W.",
                    "Koch, Rudy G.",
                    "Romans",
                    "Thomson, John W., Jr.",
                    "Other Collectors"))  

#plot

ggplot(what_coll_count,
       aes(x = July,
           y = September,
           color = coll_gr)) +
  geom_point() +
  labs(color = "Contributor",
       x = "July Contributions",
       y = "September Contributions") +
  scale_color_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 70), expand = c(0, 0.25)) +
  scale_x_continuous(limits = c(0, 500), expand = c(0, 5))

ggsave("PLOTS/July_Sept_dotplot.png",
       height = 4,
       width = 6,
       units = "in",
       dpi = "retina")

ggplot(what_coll_count,
       aes(x = Angiosperms,
           y = Nonflowering,
           color = coll_gr)) +
  geom_point() +
  labs(color = "Contributor",
       x = "Nonflowering Contributions",
       y = "Angiosperm Contributions") +
  scale_color_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 25), expand = c(0, 0.25)) +
  scale_x_continuous(limits = c(0, 500), expand = c(0, 5))

ggsave("PLOTS/July_Sept_Angio_NonF_dotplot.png",
       height = 4,
       width = 6,
       units = "in",
       dpi = "retina")

####Task: Paired Wilcox Tests####

#wilcox - data not normal
#paired - looking to see if avg collecting activity different by month or by plant group

###July vs. September

#overall

wilcox.test(what_coll_count$July,
            what_coll_count$September,
            paired = TRUE)

#p value greater than 0.05, so there is on average no collection activity difference overall

#top 7

wilcox.test(what_coll_count$July[what_coll_count$coll_gr != "Other Collectors"],
            what_coll_count$September[what_coll_count$coll_gr != "Other Collectors"],
            paired = TRUE)

#the top 7 DO differ in their activity between July and September on average

#other collectors

wilcox.test(what_coll_count$July[what_coll_count$coll_gr == "Other Collectors"],
            what_coll_count$September[what_coll_count$coll_gr == "Other Collectors"],
            paired = TRUE)

#collectors who are not the top 7 do not differ in their activity between July and September

###Angiosperms vs. Nonflowering

#overall

wilcox.test(what_coll_count$Angiosperms,
            what_coll_count$Nonflowering,
            paired = TRUE)

#p value less than 0.05, so there is definitely a difference between angiosperms and nonflowering collection contributions on average overall

#top 7

wilcox.test(what_coll_count$Angiosperms[what_coll_count$coll_gr != "Other Collectors"],
            what_coll_count$Nonflowering[what_coll_count$coll_gr != "Other Collectors"],
            paired = TRUE)

#the top 7 DO differ in their angiosperm vs. nonflowering collecting activity on average

#other collectors

wilcox.test(what_coll_count$Angiosperms[what_coll_count$coll_gr == "Other Collectors"],
            what_coll_count$Nonflowering[what_coll_count$coll_gr == "Other Collectors"],
            paired = TRUE)

#collectors other than the top seven do differ in their collection of angiosperms vs. nonflowering specimens

####Task:Make Phylogenetic tree####

library(ggtree)
library(taxize)

#filter data to only have July or September

July_Sept_Contrib <-
  SUWS_sep_collectors %>%
  filter(month_fctr == "July" |
           month_fctr == "September")

#retreiving taxonomic information

familylist <-
  July_Sept_Contrib %>%
  select(order) %>%
  distinct(order) %>%
  filter(order != "") %>%
  pull(order)

taxize_options(ncbi_sleep = 1)

classifications <- classification(familylist,
                                  db = "ncbi")

taxonomic_tree <- class2tree(classifications)

#Subsetting out by month and assigning counts

July_Contrib <-
  July_Sept_Contrib %>%
  filter(month_fctr == "July") %>%
  group_by(order,
           month_fctr) %>%
  summarize(count = n())

Sept_Contrib <-
  July_Sept_Contrib %>%
  filter(month_fctr == "September") %>%
  group_by(order,
           month_fctr) %>%
  summarize(count = n())  

All_Contrib <-
  July_Sept_Contrib %>%
  group_by(order) %>%
  summarize(count = n())

#make phylo trees

July_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  July_Contrib +
  geom_tippoint(aes(
    color = month_fctr,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(0.5, 0.4)) +
  guides(color = "none") +
  labs(size = "Contributions") +
  scale_color_manual(values = c("July" = "red"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(25,
                                   50,
                                   100,
                                   200),
                        limits = c(0,
                                   275))

print(July_tree)

ggsave("PLOTS/phylo_July.png",
       height = 9.5,
       width = 9.5,
       units = "in",
       dpi = "retina")

Sept_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  Sept_Contrib +
  geom_tippoint(aes(
    color = month_fctr,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(0.5, 0.4)) +
  guides(color = "none") +
  labs(size = "Contributions") +
  scale_color_manual(values = c("September" = "blue"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(25,
                                   50,
                                   100,
                                   200),
                        limits = c(0,
                                   275))

print(Sept_tree)

ggsave("PLOTS/phylo_Sept.png",
       height = 9.5,
       width = 9.5,
       units = "in",
       dpi = "retina")

####BREAK####
####Task: Get Township and range attached to each contribution####

SUWS_sep_collectors <- read.csv("CLEAN/SUWS_sep_collectors.csv")

#split into has coordinates and does not have coordinates

#has coords
Coords <-
  SUWS_sep_collectors %>%
  filter(str_detect(verbatimCoordinates,
                    "^4")) %>%
  separate(verbatimCoordinates,
           into = c('coordinates',
                    'tr'),
           sep = ';')

#does not have coords
No_Coords <-
  SUWS_sep_collectors %>%
  filter(!(str_detect(verbatimCoordinates,
                      "^4")))

#now split has coords into only coords and coords and t/r, removing coords dataset once split

#records that only have coords - will need to load into ArcPro to get TR
Only_Coords <-
  Coords %>%
  filter(is.na(tr)) %>%
  select(-tr) %>%
  separate(coordinates,
           into = c('N_latitude',
                    'W_longitude'),
           sep = ',')

#save Only_Coords as a csv to load into ArcPro in order to get TR attached
write.csv(Only_Coords,
          file = "CLEAN/Only_Coords_Specimens.csv",
          row.names = FALSE)

#records that have both coords and tr - coords is dropped and tr is kept
TR_from_CoordsTRCombo <-
  Coords %>%
  filter(!is.na(tr)) %>%
  select(-coordinates) %>%
  mutate(tr = str_remove(tr,
                         " sec.*"))  

#coords dataset removed
rm(Coords)

#remove Only_Coords because it will need to exported to ArcPro for analysis anyways
rm(Only_Coords)

#now split No_Coords into only has TR and no VC, removing no Coords once done

#no verbatimCoordinates
NVC <-
  No_Coords %>%
  filter(verbatimCoordinates == '')

#only township and range listed in verbatimCoordinates
Only_TR <-
  No_Coords %>%
  filter(verbatimCoordinates != '') %>%
  separate(verbatimCoordinates,
           into = c('tr1',
                    'tr2'),
           sep = ';')

#remove No_Coords
rm(No_Coords)

#remove NVC - cannot use for location analysis because no entered location data

rm(NVC)

#now split Only_TR into single township and two townships listed, removing Only_TR once done

#single township
#CAUTION/WARNING - Look at output before removing text after sec, because if two townships listed and they are separated by space instead of ;, then the second of the township/range will be lost. ensure that T and R match, and they can continue in this pipeline.

#t or r do not match
t_r_space_no_match <- c("SUWS015898",
                        "SUWS011990",
                        "SUWS016046",
                        "SUWS012301",
                        "SUWS012973",
                        "SUWS014049",
                        "SUWS012207",
                        "SUWS012219",
                        "SUWS014212",
                        "SUWS015368")

TR_Single_from_Only_TR <-
  Only_TR %>%
  filter(is.na(tr2) | tr2 == '') %>%
  filter(!(catalogNumber %in% t_r_space_no_match)) %>%
  mutate(tr = str_remove(tr1,
                         " sec.*")) %>%
  select(-tr1,
         -tr2)

#double township
TR_Double_from_Only_TR <-
  Only_TR %>%
  filter(!is.na(tr2),
         tr2 != '') %>%
  mutate(tr1 = str_remove(tr1,
                          "sec.*"),
         tr2 = str_remove(tr2,
                          "sec.*"))

#remove Only_TR
rm(Only_TR)

#remove t-r-space

rm(t_r_space_no_match)

#Parse double township

#Parsing tr1
TR_Double_from_Only_TR$t1_num <- as.numeric(gsub("T\\.?(\\d+)[NS].*", "\\1", TR_Double_from_Only_TR$tr1))

TR_Double_from_Only_TR$t1_dir <- gsub("T\\.?\\d+([NS]).*", "\\1", TR_Double_from_Only_TR$tr1)

TR_Double_from_Only_TR$r1_num <- as.numeric(gsub(".*R\\.?(\\d+)[EW]", "\\1", TR_Double_from_Only_TR$tr1))

TR_Double_from_Only_TR$r1_dir <- gsub(".*R\\.?\\d+([EW])", "\\1", TR_Double_from_Only_TR$tr1)

#Parsing tr2
TR_Double_from_Only_TR$t2_num <- as.numeric(gsub("T\\.?(\\d+)[NS].*", "\\1", TR_Double_from_Only_TR$tr2))

TR_Double_from_Only_TR$t2_dir <- gsub("T\\.?\\d+([NS]).*", "\\1", TR_Double_from_Only_TR$tr2)

TR_Double_from_Only_TR$r2_num <- as.numeric(gsub(".*R\\.?(\\d+)[EW]", "\\1", TR_Double_from_Only_TR$tr2))

TR_Double_from_Only_TR$r2_dir <- gsub(".*R\\.?\\d+([EW])", "\\1", TR_Double_from_Only_TR$tr2)

#now split by if township matches, removing TR_Double_from_Only_TR once done

#township matches
TR_Double_township_match <-
  TR_Double_from_Only_TR %>%
  filter(t1_num == t2_num)

#township does not match
TR_Double_township_not_match <-
  TR_Double_from_Only_TR %>%
  filter(!(t1_num == t2_num))

#remove TR_Double_from_Only_TR
rm(TR_Double_from_Only_TR)

#remove T don't match - cannot use
rm(TR_Double_township_not_match)

#now split by if range matches, using the dataset that has matching townships, removing township match once done

#range matches - since TR both match, also only have one tr column
TR_Double_range_match <-
  TR_Double_township_match %>%
  filter(r1_num == r2_num) %>%
  rename(tr = tr1) %>%
  select(-t1_num,
         -t1_dir,
         -r1_num,
         -r1_dir,
         -t2_num,
         -t2_dir,
         -r2_num,
         -r2_dir,
         -tr2)

#range does not match
TR_Double_range_not_match <-
  TR_Double_township_match %>%
  filter(!(r1_num == r2_num))

#remove TR_Double_township_match
rm(TR_Double_township_match)

#remove range don't match - can't use data

rm(TR_Double_range_not_match)

#now combine all datasets that have unparsed tr, removing data sets once done
unparsed_TR <-
  rbind(TR_from_CoordsTRCombo,
        TR_Single_from_Only_TR,
        TR_Double_range_match)

rm(TR_from_CoordsTRCombo,
   TR_Single_from_Only_TR,
   TR_Double_range_match)

#now parse tr for mapping
unparsed_TR$t_num <- as.numeric(gsub("T\\.?(\\d+)[NS].*", "\\1", unparsed_TR$tr))

unparsed_TR$t_dir <- gsub("T\\.?\\d+([NS]).*", "\\1", unparsed_TR$tr)

unparsed_TR$r_num <- as.numeric(gsub(".*R\\.?(\\d+)[EW]", "\\1", unparsed_TR$tr))

unparsed_TR$r_dir <- gsub(".*R\\.?\\d+([EW])", "\\1", unparsed_TR$tr)

#remove tr column
unparsed_TR <- unparsed_TR %>% select(-tr)

#Formatting townships joined from ArcPro

OC_tnshps <- read.csv("CLEAN/Only_Coords_Specimens_CoordinateTableToPoint_TableToExcel.csv")

#removing column name prefixes

names(OC_tnshps) <- sub("^Only_Coords_Specimens_CoordinateTableToPoint.",
                        "",
                        names(OC_tnshps))

names(OC_tnshps) <- sub("AddSpatialJoin.",
                        "",
                        names(OC_tnshps))

#add direction column for OC_tnshps

OC_tnshps$t_dir <- "N"

#rename columns, then getting columns in OC_tnshps to match unparsed_TR, then adding order, then reordering columns, then remove TR NA (coords outside WI)

OC_tnshps <-
  OC_tnshps %>%
  mutate(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA) %>%
  select(any_of(colnames(unparsed_TR))) %>%
  left_join(select(SUWS_sep_collectors,
                   catalogNumber,
                   collectedBy,
                   order),
            by = c("catalogNumber",
                   "collectedBy")) %>%
  select(names(unparsed_TR),
         everything()) %>%
  filter(!(is.na(t_num)))

#write csv to save

write.csv(OC_tnshps,
          file = "CLEAN/OC_tnshps_wrangled.csv",
          row.names = FALSE)

#add in rows from Only_Coords that has townships joined form ArcPro

parsed_TR <- rbind(unparsed_TR,
                   OC_tnshps)

#removed unparsed TR and OC tnshps

rm(unparsed_TR,
   OC_tnshps)

#somehow adding spaces before some townships N and after some townships E/W

parsed_TR$t_dir <-
  str_trim(parsed_TR$t_dir, side = "left")

parsed_TR$r_dir <-
  str_trim(parsed_TR$r_dir, side = "right")

#save parsed TR

write.csv(parsed_TR,
          file = "CLEAN/parsed_TR.csv",
          row.names = FALSE)

####Task: Count nonrandom Points - overall collection####

parsed_TR <- read.csv("CLEAN/parsed_TR.csv")

wn_state_count <- as.integer(nrow(parsed_TR))

#5822 pts within state

n_reg_ctys <- c("Douglas",
                "Burnett",
                "Polk",
                "Barron",
                "Washburn",
                "Rusk",
                "Sawyer",
                "Bayfield",
                "Ashland",
                "Price",
                "Taylor",
                "Lincoln",
                "Oneida",
                "Vilas",
                "Florence",
                "Forest",
                "Langlade")

wn_cty_n_reg <- as.integer(sum(parsed_TR$county %in% n_reg_ctys))

#5364 w/n northern region

wn_douglas <- as.integer(sum(parsed_TR$county == "Douglas"))

#3521 in douglas county

#count nonrandom points within each county for statewide

NR_ea_cty_statewide <-
  parsed_TR %>%
  count(county)

#count nonrandom points within each county for northern region

NR_ea_cty_n_reg <-
  parsed_TR %>%
  filter(county %in% n_reg_ctys) %>%
  count(county)

#count nonrandom points for each township for northern region

NR_ea_twnshp_n_reg <-
  parsed_TR %>%
  filter(county %in% n_reg_ctys) %>%
  count(t_num,
        t_dir,
        r_num,
        r_dir)

#count nonrandom points for each township for douglas county

NR_ea_twnshp_douglas_cty <-
  parsed_TR %>%
  filter(county == "Douglas") %>%
  count(t_num,
        t_dir,
        r_num,
        r_dir)

####Task: filter parsed TR by month####

Sept_parsed_TR <-
  parsed_TR %>%
  filter(month_fctr == "September")

July_parsed_TR <-
  parsed_TR %>%
  filter(month_fctr == "July")

####Task: count nonrandom points - Sept####

Sept_wn_state_count <- as.integer(nrow(Sept_parsed_TR))

#1106 pts within state

n_reg_ctys <- c("Douglas",
                "Burnett",
                "Polk",
                "Barron",
                "Washburn",
                "Rusk",
                "Sawyer",
                "Bayfield",
                "Ashland",
                "Price",
                "Taylor",
                "Lincoln",
                "Oneida",
                "Vilas",
                "Florence",
                "Forest",
                "Langlade")

Sept_wn_cty_n_reg <- as.integer(sum(Sept_parsed_TR$county %in% n_reg_ctys))

#1054 w/n northern region

Sept_wn_douglas <- as.integer(sum(Sept_parsed_TR$county == "Douglas"))

#3521 in douglas county

#count nonrandom points within each county for statewide

Sept_NR_ea_cty_statewide <-
  Sept_parsed_TR %>%
  count(county)

#count nonrandom points within each county for northern region

Sept_NR_ea_cty_n_reg <-
  Sept_parsed_TR %>%
  filter(county %in% n_reg_ctys) %>%
  count(county)

#count nonrandom points for each township for northern region

Sept_NR_ea_twnshp_n_reg <-
  Sept_parsed_TR %>%
  filter(county %in% n_reg_ctys) %>%
  count(t_num,
        t_dir,
        r_num,
        r_dir)

#count nonrandom points for each township for douglas county

Sept_NR_ea_twnshp_douglas_cty <-
  Sept_parsed_TR %>%
  filter(county == "Douglas") %>%
  count(t_num,
        t_dir,
        r_num,
        r_dir)

####Task: Count nonrandom points - July####

July_wn_state_count <- as.integer(nrow(July_parsed_TR))

#1805 pts within state

n_reg_ctys <- c("Douglas",
                "Burnett",
                "Polk",
                "Barron",
                "Washburn",
                "Rusk",
                "Sawyer",
                "Bayfield",
                "Ashland",
                "Price",
                "Taylor",
                "Lincoln",
                "Oneida",
                "Vilas",
                "Florence",
                "Forest",
                "Langlade")

July_wn_cty_n_reg <- as.integer(sum(July_parsed_TR$county %in% n_reg_ctys))

#1714 w/n northern region

July_wn_douglas <- as.integer(sum(July_parsed_TR$county == "Douglas"))

#695 in douglas county

#count nonrandom points within each county for statewide

July_NR_ea_cty_statewide <-
  July_parsed_TR %>%
  count(county)

#count nonrandom points within each county for northern region

July_NR_ea_cty_n_reg <-
  July_parsed_TR %>%
  filter(county %in% n_reg_ctys) %>%
  count(county)

#count nonrandom points for each township for northern region

July_NR_ea_twnshp_n_reg <-
  July_parsed_TR %>%
  filter(county %in% n_reg_ctys) %>%
  count(t_num,
        t_dir,
        r_num,
        r_dir)

#count nonrandom points for each township for douglas county

July_NR_ea_twnshp_douglas_cty <-
  July_parsed_TR %>%
  filter(county == "Douglas") %>%
  count(t_num,
        t_dir,
        r_num,
        r_dir)

####Task: add random pt counts to nonrandom pt counts - overall collection####

#load in data

R_ea_cty_n_reg <- read.csv("CLEAN/AP_Random_pts_count/All/Random_ea_cty_n_reg.csv")

R_ea_cty_statewide <- read.csv("CLEAN/AP_Random_pts_count/All/Random_ea_cty_statewide.csv")

R_ea_twnshp_douglas_cty <- read.csv("CLEAN/AP_Random_pts_count/All/Random_ea_tnshp_douglas_cty.csv")

R_ea_twnshp_n_reg <- read.csv("CLEAN/AP_Random_pts_count/All/Random_ea_tnshp_n_reg.csv")

#join NR and R, then keep only county name, random point count, nonrandom point count, then rename point count columns, then turn NAs to zeros

fj_ea_cty_n_reg <-
  full_join(R_ea_cty_n_reg,
            NR_ea_cty_n_reg,
            by = c("COUNTY_NAM" = "county")) %>%
  select(COUNTY_NAM,
         Point_Count,
         n) %>%
  rename(County = COUNTY_NAM,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0))

fj_ea_cty_statewide <-
  full_join(R_ea_cty_statewide,
            NR_ea_cty_statewide,
            by = c("COUNTY_NAM" = "county")) %>%
  select(COUNTY_NAM,
         Point_Count,
         n) %>%
  rename(County = COUNTY_NAM,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0))

fj_ea_twnshp_douglas_cty <-
  full_join(R_ea_twnshp_douglas_cty,
            NR_ea_twnshp_douglas_cty,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         Point_Count,
         n) %>%
  rename(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0),
         t_dir = replace_na(t_dir, "N"))

fj_ea_twnshp_n_reg <-
  full_join(R_ea_twnshp_n_reg,
            NR_ea_twnshp_n_reg,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         Point_Count,
         n) %>%
  rename(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0),
         t_dir = replace_na(t_dir, "N"))

####Task: calc Kadmon Index - overall collection####

fj_ea_cty_n_reg <-
  fj_ea_cty_n_reg %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/wn_cty_n_reg) * wn_cty_n_reg)),
         kadmon_index_bottom = sqrt((R_pt_ct/wn_cty_n_reg) * (1 - (R_pt_ct/wn_cty_n_reg)) * wn_cty_n_reg),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

fj_ea_cty_statewide <-
  fj_ea_cty_statewide %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/wn_state_count) * wn_state_count)),
         kadmon_index_bottom = sqrt((R_pt_ct/wn_state_count) * (1 - (R_pt_ct/wn_state_count)) * wn_state_count),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

fj_ea_twnshp_douglas_cty <-
  fj_ea_twnshp_douglas_cty %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/wn_douglas) * wn_douglas)),
         kadmon_index_bottom = sqrt((R_pt_ct/wn_douglas) * (1 - (R_pt_ct/wn_douglas)) * wn_douglas),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

fj_ea_twnshp_n_reg <-
  fj_ea_twnshp_n_reg %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/wn_cty_n_reg) * wn_cty_n_reg)),
         kadmon_index_bottom = sqrt((R_pt_ct/wn_cty_n_reg) * (1 - (R_pt_ct/wn_cty_n_reg)) * wn_cty_n_reg),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

####Task: add random pt counts to nonrandom pt counts - Sept####

#load in data

Sept_R_ea_cty_n_reg <- read.csv("CLEAN/AP_Random_pts_count/Sept/Sept_Random_ea_cty_n_reg.csv")

Sept_R_ea_cty_statewide <- read.csv("CLEAN/AP_Random_pts_count/Sept/Sept_Random_ea_cty_statewide.csv")

Sept_R_ea_twnshp_douglas_cty <- read.csv("CLEAN/AP_Random_pts_count/Sept/Sept_Random_ea_tnshp_douglas_cty.csv")

Sept_R_ea_twnshp_n_reg <- read.csv("CLEAN/AP_Random_pts_count/Sept/Sept_Random_ea_tnshp_n_reg.csv")

#join NR and R, then keep only county name, random point count, nonrandom point count, then rename point count columns, then turn NAs to zeros

Sept_fj_ea_cty_n_reg <-
  full_join(Sept_R_ea_cty_n_reg,
            Sept_NR_ea_cty_n_reg,
            by = c("COUNTY_NAM" = "county")) %>%
  select(COUNTY_NAM,
         Point_Count,
         n) %>%
  rename(County = COUNTY_NAM,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0))

Sept_fj_ea_cty_statewide <-
  full_join(Sept_R_ea_cty_statewide,
            Sept_NR_ea_cty_statewide,
            by = c("COUNTY_NAM" = "county")) %>%
  select(COUNTY_NAM,
         Point_Count,
         n) %>%
  rename(County = COUNTY_NAM,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0))

Sept_fj_ea_twnshp_douglas_cty <-
  full_join(Sept_R_ea_twnshp_douglas_cty,
            Sept_NR_ea_twnshp_douglas_cty,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         Point_Count,
         n) %>%
  rename(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0),
         t_dir = replace_na(t_dir, "N"))

Sept_fj_ea_twnshp_n_reg <-
  full_join(Sept_R_ea_twnshp_n_reg,
            Sept_NR_ea_twnshp_n_reg,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         Point_Count,
         n) %>%
  rename(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0),
         t_dir = replace_na(t_dir, "N"))

####Task: calc Kadmon Index - Sept####

Sept_fj_ea_cty_n_reg <-
  Sept_fj_ea_cty_n_reg %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/Sept_wn_cty_n_reg) * Sept_wn_cty_n_reg)),
         kadmon_index_bottom = sqrt((R_pt_ct/Sept_wn_cty_n_reg) * (1 - (R_pt_ct/Sept_wn_cty_n_reg)) * Sept_wn_cty_n_reg),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

Sept_fj_ea_cty_statewide <-
  Sept_fj_ea_cty_statewide %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/Sept_wn_state_count) * Sept_wn_state_count)),
         kadmon_index_bottom = sqrt((R_pt_ct/Sept_wn_state_count) * (1 - (R_pt_ct/Sept_wn_state_count)) * Sept_wn_state_count),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

Sept_fj_ea_twnshp_douglas_cty <-
  Sept_fj_ea_twnshp_douglas_cty %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/Sept_wn_douglas) * Sept_wn_douglas)),
         kadmon_index_bottom = sqrt((R_pt_ct/Sept_wn_douglas) * (1 - (R_pt_ct/Sept_wn_douglas)) * Sept_wn_douglas),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

Sept_fj_ea_twnshp_n_reg <-
  Sept_fj_ea_twnshp_n_reg %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/Sept_wn_cty_n_reg) * Sept_wn_cty_n_reg)),
         kadmon_index_bottom = sqrt((R_pt_ct/Sept_wn_cty_n_reg) * (1 - (R_pt_ct/Sept_wn_cty_n_reg)) * Sept_wn_cty_n_reg),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

####Task: add random pt counts to nonrandom pt counts - July####

#load in data

July_R_ea_cty_n_reg <- read.csv("CLEAN/AP_Random_pts_count/July/July_Random_ea_cty_n_reg.csv")

July_R_ea_cty_statewide <- read.csv("CLEAN/AP_Random_pts_count/July/July_Random_ea_cty_statewide.csv")

July_R_ea_twnshp_douglas_cty <- read.csv("CLEAN/AP_Random_pts_count/July/July_Random_ea_tnshp_douglas_cty.csv")

July_R_ea_twnshp_n_reg <- read.csv("CLEAN/AP_Random_pts_count/July/July_Random_ea_tnshp_n_reg.csv")

#join NR and R, then keep only county name, random point count, nonrandom point count, then rename point count columns, then turn NAs to zeros

July_fj_ea_cty_n_reg <-
  full_join(July_R_ea_cty_n_reg,
            July_NR_ea_cty_n_reg,
            by = c("COUNTY_NAM" = "county")) %>%
  select(COUNTY_NAM,
         Point_Count,
         n) %>%
  rename(County = COUNTY_NAM,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0))

July_fj_ea_cty_statewide <-
  full_join(July_R_ea_cty_statewide,
            July_NR_ea_cty_statewide,
            by = c("COUNTY_NAM" = "county")) %>%
  select(COUNTY_NAM,
         Point_Count,
         n) %>%
  rename(County = COUNTY_NAM,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0))

July_fj_ea_twnshp_douglas_cty <-
  full_join(July_R_ea_twnshp_douglas_cty,
            July_NR_ea_twnshp_douglas_cty,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         Point_Count,
         n) %>%
  rename(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0),
         t_dir = replace_na(t_dir, "N"))

July_fj_ea_twnshp_n_reg <-
  full_join(July_R_ea_twnshp_n_reg,
            July_NR_ea_twnshp_n_reg,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         Point_Count,
         n) %>%
  rename(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA,
         R_pt_ct = Point_Count,
         NR_pt_ct = n) %>%
  mutate(NR_pt_ct = replace_na(NR_pt_ct, 0),
         t_dir = replace_na(t_dir, "N"))

####Task: calc Kadmon Index - July####

July_fj_ea_cty_n_reg <-
  July_fj_ea_cty_n_reg %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/July_wn_cty_n_reg) * July_wn_cty_n_reg)),
         kadmon_index_bottom = sqrt((R_pt_ct/July_wn_cty_n_reg) * (1 - (R_pt_ct/July_wn_cty_n_reg)) * July_wn_cty_n_reg),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

July_fj_ea_cty_statewide <-
  July_fj_ea_cty_statewide %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/July_wn_state_count) * July_wn_state_count)),
         kadmon_index_bottom = sqrt((R_pt_ct/July_wn_state_count) * (1 - (R_pt_ct/July_wn_state_count)) * July_wn_state_count),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

July_fj_ea_twnshp_douglas_cty <-
  July_fj_ea_twnshp_douglas_cty %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/July_wn_douglas) * July_wn_douglas)),
         kadmon_index_bottom = sqrt((R_pt_ct/July_wn_douglas) * (1 - (R_pt_ct/July_wn_douglas)) * July_wn_douglas),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)

July_fj_ea_twnshp_n_reg <-
  July_fj_ea_twnshp_n_reg %>%
  mutate(kadmon_index_top = (NR_pt_ct - ((R_pt_ct/July_wn_cty_n_reg) * July_wn_cty_n_reg)),
         kadmon_index_bottom = sqrt((R_pt_ct/July_wn_cty_n_reg) * (1 - (R_pt_ct/July_wn_cty_n_reg)) * July_wn_cty_n_reg),
         kadmon_index = kadmon_index_top/kadmon_index_bottom)


####Task: get PLSS added for mapping townships####

#PLSS
PLSS <- read.csv("RAW/PLSS_Townships_PairwiseDisso.xls - PLSS_Townships_PairwiseDisso.csv")

#all

fj_ea_twnshp_douglas_cty_PLSS <-
  left_join(fj_ea_twnshp_douglas_cty,
            PLSS,
            by = c("t_num" = "TWP",
                   "r_num" = "RNG",
                   "r_dir" = "DIR_ALPHA"))

fj_ea_twnshp_n_reg_PLSS <-
  left_join(fj_ea_twnshp_n_reg,
            PLSS,
            by = c("t_num" = "TWP",
                   "r_num" = "RNG",
                   "r_dir" = "DIR_ALPHA"))

#July

July_fj_ea_twnshp_douglas_cty_PLSS <-
  left_join(July_fj_ea_twnshp_douglas_cty,
            PLSS,
            by = c("t_num" = "TWP",
                   "r_num" = "RNG",
                   "r_dir" = "DIR_ALPHA"))

July_fj_ea_twnshp_n_reg_PLSS <-
  left_join(July_fj_ea_twnshp_n_reg,
            PLSS,
            by = c("t_num" = "TWP",
                   "r_num" = "RNG",
                   "r_dir" = "DIR_ALPHA"))

#Sept

Sept_fj_ea_twnshp_douglas_cty_PLSS <-
  left_join(Sept_fj_ea_twnshp_douglas_cty,
            PLSS,
            by = c("t_num" = "TWP",
                   "r_num" = "RNG",
                   "r_dir" = "DIR_ALPHA"))

Sept_fj_ea_twnshp_n_reg_PLSS <-
  left_join(Sept_fj_ea_twnshp_n_reg,
            PLSS,
            by = c("t_num" = "TWP",
                   "r_num" = "RNG",
                   "r_dir" = "DIR_ALPHA"))
####Task: export Kadmon Indexes for mapping####

#remove datasets that won't be exported

data_to_keep <- c("July_fj_ea_cty_n_reg",
                  "July_fj_ea_cty_statewide",
                  "July_fj_ea_twnshp_douglas_cty_PLSS",
                  "July_fj_ea_twnshp_n_reg_PLSS",
                  
                  "Sept_fj_ea_cty_n_reg",
                  "Sept_fj_ea_cty_statewide",
                  "Sept_fj_ea_twnshp_douglas_cty_PLSS",
                  "Sept_fj_ea_twnshp_n_reg_PLSS",
                  
                  "fj_ea_cty_n_reg",
                  "fj_ea_cty_statewide",
                  "fj_ea_twnshp_douglas_cty_PLSS",
                  "fj_ea_twnshp_n_reg_PLSS")

rm(list = setdiff(ls(), data_to_keep))

#write csvs

list_of_dfs <-
  list("July_fj_ea_cty_n_reg" = July_fj_ea_cty_n_reg,
       "July_fj_ea_cty_statewide" = July_fj_ea_cty_statewide,
       "July_fj_ea_twnshp_douglas_cty_PLSS" = July_fj_ea_twnshp_douglas_cty_PLSS,
       "July_fj_ea_twnshp_n_reg_PLSS" = July_fj_ea_twnshp_n_reg_PLSS,
       
       "Sept_fj_ea_cty_n_reg" = Sept_fj_ea_cty_n_reg,
       "Sept_fj_ea_cty_statewide" = Sept_fj_ea_cty_statewide,
       "Sept_fj_ea_twnshp_douglas_cty_PLSS" = Sept_fj_ea_twnshp_douglas_cty_PLSS,
       "Sept_fj_ea_twnshp_n_reg_PLSS" = Sept_fj_ea_twnshp_n_reg_PLSS,
       
       "fj_ea_cty_n_reg" = fj_ea_cty_n_reg,
       "fj_ea_cty_statewide" = fj_ea_cty_statewide,
       "fj_ea_twnshp_douglas_cty_PLSS" = fj_ea_twnshp_douglas_cty_PLSS,
       "fj_ea_twnshp_n_reg_PLSS" = fj_ea_twnshp_n_reg_PLSS)

output_dir <- "./CLEAN/Kadmon_Indices_Mapping/"

for (name in names(list_of_dfs)) {
  # Construct the full file path using paste0()
  file_path <- paste0(output_dir, name, ".csv")
  
  # Write the data frame to a CSV file, excluding row names
  write.csv(list_of_dfs[[name]], file = file_path, row.names = FALSE)
  
  cat(sprintf("Wrote %s\n", file_path))
}

####Junkyard####

# #the following are edits to how collectors are displayed in dataset - wanted in separate columns if more than one
# 
# #Task: Parse Collectors
# 
# Coll_pst_sep_col <-
#   SUWS_clean %>%
#   select(catalogNumber,
#          recordedBy) %>%
#   separate(recordedBy,
#            into = c('recordedBy_primary',
#                     'recordedBy_secondary'),
#            sep = ';') %>%
#   separate(recordedBy_secondary,
#            into = c('recordedBy_secondary_last',
#                     'recordedBy_secondary_first',
#                     'recordedBy_tertiary_last',
#                     'recordedBy_tertiary_first'),
#            sep = ",") %>%
#   unite(col = recordedBy_secondary,
#         recordedBy_secondary_last,
#         recordedBy_secondary_first,
#         sep = ',',
#         na.rm = TRUE) %>%
#   unite(col = recordedBy_tertiary,
#         recordedBy_tertiary_last,
#         recordedBy_tertiary_first,
#         sep = ',',
#         na.rm = TRUE)
# 
# 
# 
# #trim collector column - somehow adding spaces before some names
# 
# Coll_cty_CN$collectedBy <-
#   str_trim(Coll_cty_CN$collectedBy, side = "left")
# 
# 
# 
# 
# write.csv(Coll_pst_sep_col,
#           file = "CLEAN/Coll_pst_sep_col.csv",
#           row.names = FALSE)
# 
# #integrate Coll_pst_sep_col to SUWS_clean
# 
# SUWS_clean <-
#   left_join(SUWS_clean,
#             Coll_pst_sep_col[ ,
#                               c("catalogNumber",
#                                 "recordedBy_primary",
#                                 "recordedBy_secondary",
#                                 "recordedBy_tertiary")],
#             by = "catalogNumber")
