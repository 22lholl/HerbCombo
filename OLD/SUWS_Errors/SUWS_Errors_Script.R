#Lillian Holl
#SUWS WisFlora Errors
#2/8/2026

getwd()

#setwd to SUWS_Errors folder
setwd()

library(tidyverse)

#SUWS WisFlora, unaltered
SUWS <- read.csv("RAW/occurrence_data_20250922105936_DarwinCore.csv")

####Finding duplicates####

#this counts the instances of catalogNumbers in the SUWS WisFlora data. 
#note: a number higher than one shouldn't happen in practice. catalogNumbers are the unique number on each herbarium sheet.

catalogNumber_count <-
  SUWS %>% 
  count(catalogNumber)

#extract vector of duplicate catalogNumbers
#note: there are 31 duplicate catalogNumbers, which indicates 62 records affected

DUP_CN <-
  catalogNumber_count$catalogNumber[catalogNumber_count$n > 1]

#the following lists the catalogNumber associated with two specimen records

# DUP_CN <- c("SUWS017400",
#             "SUWS017401",
#             "SUWS017404",
#             "SUWS017409",
#             "SUWS017424",
#             "SUWS017425",
#             "SUWS017438",
#             "SUWS017439",
#             "SUWS017442",
#             "SUWS017443",
#             "SUWS017444",
#             "SUWS017445",
#             "SUWS017447",
#             "SUWS017452",
#             "SUWS017507",
#             "SUWS017540",
#             "SUWS017541",
#             "SUWS017546",
#             "SUWS017548",
#             "SUWS017550",
#             "SUWS017551",
#             "SUWS017554",
#             "SUWS017543",
#             "SUWS017431",
#             "SUWS017430",
#             "SUWS017450",
#             "SUWS017410",
#             "SUWS017403",
#             "SUWS017451",
#             "SUWS017416",
#             "SUWS017552")

#the following lists id of duplicates that were found and verified by hand
#note: id is unique to each entry in spreadsheet. Noramlly equivalent to catalogNumber, but in this case with duplicate catalogNumbers it can be used to indicate which entry in particular was determined to be "correct". (correctness varied - could be that taxonomy updated but left behind old record, sometimes was that one record had more complete info)

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

#the following lists the catalogNumbers of specimens that couldn't be located for verification by hand

NON_VER_DUP_CN <- c("SUWS017400",
                    "SUWS017401",
                    "SUWS017403")

####looking at duplicates in SUWS WisFlora data####

#this pulls all 62 affected records

SUWS_DUP_CN <- 
  SUWS %>%
  filter(catalogNumber %in% DUP_CN)

#this pulls all hand verified records (28 specimens)

SUWS_VER_DUP_CN_id <-
  SUWS %>%
  filter(id %in% VER_DUP_CN_id)

#this pulls all unverified records (6 entries)
#note: includes 3 instances of "true" records and 3 instances of a duplicate, and they cannot be distinguished from each other because I couldn't find the original herbarium sheet

SUWS_NON_VER_DUP_CN <-
  SUWS %>%
  filter(catalogNumber %in% NON_VER_DUP_CN)

#note: record math
#28 verified records + 28 discarded duplicates + 6 unverified records = 62 total affected records


####Fixing Braashier on SUWS011985####

#collectors in separate columns
Coll_sep_col <-
  SUWS %>%
  select(catalogNumber,
         county,
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

#finding misspelling of Brashier
#note: no one else in database with name similar to Brashier (or a last name only entry like Brashier and the people they collected with), so more likely a misspelling than a single entry of a person named Braashier

sort(unique(Coll_sep_col$recordedBy_secondary))

#fix braashier - SUWS011985
Coll_sep_col[Coll_sep_col$catalogNumber == "SUWS011985", "recordedBy_secondary"] <- "Brashier"

SUWS[SUWS$catalogNumber == "SUWS011985", "recordedBy"] <- "Holden; Brashier"

###coordinates outside Wisconsin####

#how OC_tnshps was created - these are specimens that did not have the township data I needed for a particular map, but they did have coordinates in the verbatimCoordinates column. I loaded their coordinates into ArcPro along with a WI township map, plotted the points, and joined the township information with the catalogNumbers from the points based on location (if located in a particular township, the catalogNumber of the specimen now also had associated township information when exported back to RStudio)

OC_tnshps <- read.csv("RAW/Only_Coords_Specimens_CoordinateTableToPoint_TableToExcel.csv")

not_WI_CN <-
  OC_tnshps %>%
  filter(is.na(TWP))

#filter for NAs - un matched means they were out of range of WI townships, and thus also considered out of state

Coord_not_WI <-
  SUWS %>%
  filter(catalogNumber %in% not_WI_CN$catalogNumber)

#note: All three are listed as collected in Wisconsin - I think these three are georeferencing errors with the coordinates when they were put in the database. The two collected by Jurkowski (SUWS016783 & SUWS016784) have coordinates north of where the locality field say they were collected (Superior High School), so likely a problem with latitude. The one collected by Brashier (SUWS011950) has really high coordinate uncertainty (2500 m?) when they were normally very good about listing townships otherwise...

#other geographic phenomena of note: collectors sometimes recorded a double entry where townships/ranges/sections may differ. I this was probably intentional in a pre-mobile GPS (phone) world, a sort of "best guess" on fairly precise location if they were close to the boundary.