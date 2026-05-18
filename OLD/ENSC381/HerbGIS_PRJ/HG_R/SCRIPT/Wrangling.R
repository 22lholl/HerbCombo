#Lillian Holl
#GEOG 491
#HerbGIS - Wrangling (code archive for data prep - code to load ready-to-use versions typically saved in StartupPDD)
#9/24/2025

####SUWS to SUWS_clean - column and row clean-up####

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
              'recordId')

#checking to see if counties come out right

SUWS %>% count(county)

#the following lists the catalogNumbers of Specimens with no associated county

NO_CTY <- c('SUWS010464',
            'SUWS011012',
            'SUWS014413',
            'SUWS014573',
            'SUWS015886',
            'SUWS015936')

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

#creates and saves useable dataset that has had all extraneous columns and also specimens with no county removed, includes fix to duplicate catalogNumber

SUWS_clean <- 
  anti_join(SUWS,
            NOT_VER_DUP_CN_tbl,
            by = "id") %>%
  select(-all_of(NA_col),
         -all_of(Rep_col),
         -all_of(Misc_col)) %>%
  filter(!(catalogNumber %in% NO_CTY))

write.csv(SUWS_clean,
          file = "CLEAN/SUWS_clean.csv",
          row.names = FALSE)

####Task: Wrangle Data for how many specimens per county####

#Test to make sure there are no duplicate catalogNumber

SUWS_clean$catalogNumber[duplicated(SUWS_clean$catalogNumber)]

#count the number of specimens per county

#n-distinct is tricky here - it is counting the number of distinct catalogNumber in the county (indicates unique records), not necessarily individual rows (would overrepresent because of duplicate catalogNumber if exists)
#n() will show number of rows

Spec_per_cty <-
  SUWS_clean %>%
  group_by(county) %>%
  summarize(distinct_specimens = n_distinct(catalogNumber))

#save to csv for ArcGIS Pro

write.csv(Spec_per_cty,
          file = "CLEAN/Spec_per_cty.csv",
          row.names = FALSE)

####Task: Parse Collectors####

Coll_pst_sep_col <-
  SUWS_clean %>%
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

#fix braashier - SUWS011985
Coll_pst_sep_col[Coll_pst_sep_col$catalogNumber == "SUWS011985", "recordedBy_secondary"] <- "Brashier"

write.csv(Coll_pst_sep_col,
          file = "CLEAN/Coll_pst_sep_col.csv",
          row.names = FALSE)


####Task: Get Primary, Secondary, Tertiary Collectors all in one column + arcpro mappable####

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

write.csv(Coll_cty_CN,
          file = "CLEAN/Coll_cty_CN.csv",
          row.names = FALSE)

#code below creates a mappable version for arcpro, where the number of collectors is associated with a county

#NOTE: There is specimens with no collector listed that count in this dataset. If there are multiple specimens with no collector in the same county, they count as the same person. A blank space with no collector essentially counts as another name of a collector.
Coll_per_cty <-
  Coll_cty_CN %>%
  group_by(county) %>%
  summarize(specimens = n_distinct(collectedBy))

write.csv(Coll_per_cty,
          file = "CLEAN/Coll_per_cty.csv",
          row.names = FALSE)

####Task: Parse Township/Range, get number of specimens per township####

#split into has coordinates and does not have coordinates

#has coords
Coords <-
  SUWS_clean %>%
  select(catalogNumber,
         verbatimCoordinates) %>%
  filter(str_detect(verbatimCoordinates,
                    "^4")) %>%
  separate(verbatimCoordinates,
           into = c('coordinates',
                    'tr'),
           sep = ';')

#does not have coords
No_Coords <-
  SUWS_clean %>%
  select(catalogNumber,
         verbatimCoordinates) %>%
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

#no verbatimCoordinates, does have county in full dataset (which is why it starts from there)
NVC <-
  SUWS_clean %>%
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

#now split by if range matches, using the dataset that has matching townships, removing township match once done

#range matches - since TR both match, also only have one tr column
TR_Double_range_match <-
  TR_Double_township_match %>%
  filter(r1_num == r2_num) %>%
  select(catalogNumber,
         tr1) %>%
  rename(tr = tr1)

#range does not match
TR_Double_range_not_match <-
  TR_Double_township_match %>%
  filter(!(r1_num == r2_num))

#remove TR_Double_township_match
rm(TR_Double_township_match)

#now combine all datasets that have unparsed tr, removing data sets once done
TR <-
  rbind(TR_from_CoordsTRCombo,
        TR_Single_from_Only_TR,
        TR_Double_range_match)

rm(TR_from_CoordsTRCombo,
   TR_Single_from_Only_TR,
   TR_Double_range_match)

write.csv(TR,
          file = "CLEAN/TR_CN.csv",
          row.names = FALSE)

#now parse tr for mapping
TR$t_num <- as.numeric(gsub("T\\.?(\\d+)[NS].*", "\\1", TR$tr))

TR$t_dir <- gsub("T\\.?\\d+([NS]).*", "\\1", TR$tr)

TR$r_num <- as.numeric(gsub(".*R\\.?(\\d+)[EW]", "\\1", TR$tr))

TR$r_dir <- gsub(".*R\\.?\\d+([EW])", "\\1", TR$tr)

#remove tr column
TR <- TR %>% select(-tr)

#OC_tnshps - has Only_Coords Specimens that have tonwship info in same format as TR
OC_tnshps <- read.csv("CLEAN/OC_tnshps.csv")

#add in rows from Only_Coords that has townships joined form ArcPro

TR <- rbind(TR,
            OC_tnshps)

#how many collections per township?

Spec_per_tnshp <-
  TR %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir) %>%
  summarize(distinct_specimens = n_distinct(catalogNumber))

write.csv(Spec_per_tnshp,
          file = "CLEAN/Spec_per_tnshp.csv",
          row.names = FALSE)

####Task: pull out duplicate CN so can show easy####

#had to rerun most of script to make SUWS_clean, except for the part where it pulls out the DUP_CN - instead, I told it to keep only duplicate CN, which makes the dataset below

DUP_CN_tbl <-
  SUWS_clean %>%
  filter(catalogNumber %in% DUP_CN)

#write .csv to save

write.csv(DUP_CN_tbl,
          file = "CLEAN/DUP_CN_tbl.csv",
          row.names = FALSE)

####Task: Get number of collectors per township####  

#Join TR and Coll_cty_CN by catalogNumber
#CAUTION: filter(!is.na(t_num)) removes any specimens that have no township/range listed (aka the specimens that only are at the county level)

Coll_per_tnshp <-
  left_join(Coll_cty_CN,
            TR,
            by = "catalogNumber") %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir) %>%
  summarize(distinct_specimens = n_distinct(collectedBy))

write.csv(Coll_per_tnshp,
          file = "CLEAN/Coll_per_tnshp.csv",
          row.names = FALSE)

####Task: Format OC_tnshps so can put in TR workflow####

OC_tnshps <- read.csv("RAW/Only_Coords_Specimens_CoordinateTableToPoint_TableToExcel.csv")

OC_tnshps$t_dir <- "N"

#includes TEMPORARY FIX removing specimens with no townships that could be joined (aka coords were outside Wisconsin)
OC_tnshps <-
  OC_tnshps %>%
  select(catalogNumber,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA) %>%
  rename(t_num = TWP,
         r_num = RNG,
         r_dir = DIR_ALPHA) %>%
  filter(!(is.na(t_num)))

write.csv(OC_tnshps,
          file = "CLEAN/OC_tnshps.csv",
          row.names = FALSE)

####Task: Wrangle Wonky Township Data - joining shapefile to data here####

#PLSS table from GIS shapefile
PLSS <- 
  read.csv("RAW/PLSS_Townships_1983HARN_TableToExcel.xlsx - PLSS_Townships_1983HARN.csv")

#Coll_per_tnshp - has TN and number of coll per township, for ease of mapping
Coll_per_tnshp <- read.csv("CLEAN/Coll_per_tnshp.csv")

#join Coll_per_tnshp and Spec_per_tnshp
Tnshp_Coll <-
  left_join(PLSS,
            Coll_per_tnshp,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  rename(distinct_collectors = distinct_specimens)

Tnshp_Coll_Spec <-
  left_join(Tnshp_Coll,
            Spec_per_tnshp,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         distinct_specimens,
         distinct_collectors) %>%
  filter(!(is.na(distinct_specimens)))

write.csv(Tnshp_Coll_Spec,
          file = "CLEAN/Tnshp_Coll_Spec_AP.csv",
          row.names = FALSE)

####Task: histogram of who collected how much####

#using Coll_cty_CN

histo <-
  Coll_cty_CN %>%
  group_by(collectedBy) %>%
  count(collectedBy)

#plot that compares how many people only contributed a small amount of specimens (a lot) vs people who contributed a lot of specimens (very few)

ggplot(histo,
       aes(x = n)) +
  geom_histogram() +
  labs(x = "Contributed Specimens",
       y = "Number of Collectors") +
  theme(axis.text = element_text(size = 20),
        axis.title = element_text(size = 25)) +
  geom_vline(xintercept = 125,
             col = "red",
             size = 2)

#same thing but with below 125 for number of contributed specimens

ggplot(subset(histo,
              n < 125),
       aes(x = n)) +
  geom_histogram() +
  labs(title = "Contributed Specimens compared to Number of Collectors (who contribute 125 specimens or less)",
       x = "Number of Contributed Specimens",
       y = "Number of Collectors")

# every person by name who has contributed with their number of collected specimens - graph gets really busy yikes

ggplot(histo) +
  geom_bar(aes(x = reorder(collectedBy,
                           -n),
               y = n),
           stat = "identity") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Name of Collector",
       y = "Number of collections",
       title = "Collector compared to number of collections")

#graph with people who have 125 specimens or more

ggplot(subset(histo,
              n > 125),
       aes(x = reorder(collectedBy,
                       -n),
           y = n)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = n,
                y = 0),
            vjust = -0.5,
            size = 10,
            color = "white") +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   color = "black"),
        axis.text = element_text(size = 20),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 20)) +
  labs(y = "Number of contributions")

#here's some math - collectors show up 6,457 times in 5,222 collections. the collectors with more than 125 represent only a fraction of what's in the database - 3,187/6,457 is ~49%. Which means 51% of the time collectors tend to have a lower frequency of collection
#^numbers have changed for above

#293 unique collectors, counting no collector as one


#look at all the people who contributed less than 125 specimens!

ggplot(subset(histo,
              n < 125)) +
  geom_bar(aes(x = reorder(collectedBy,
                           -n),
               y = n),
           stat = "identity") +
  theme(axis.text.x = element_text(angle = 90))

#look at all the people who contributed only 1 or two specimens!

ggplot(subset(histo,
              n < 3)) +
  geom_bar(aes(x = reorder(collectedBy,
                           -n),
               y = n),
           stat = "identity") +
  theme(axis.text.x = element_text(angle = 90))

####Task: Make data table of numbers by county/township numbers by collector (mappable)####

#now parse tr for mapping
TR$t_num <- as.numeric(gsub("T\\.?(\\d+)[NS].*", "\\1", TR$tr))

TR$t_dir <- gsub("T\\.?\\d+([NS]).*", "\\1", TR$tr)

TR$r_num <- as.numeric(gsub(".*R\\.?(\\d+)[EW]", "\\1", TR$tr))

TR$r_dir <- gsub(".*R\\.?\\d+([EW])", "\\1", TR$tr)

#remove tr column
TR <- TR %>% select(-tr)

#add in rows from Only_Coords that has townships joined form ArcPro
TR <- rbind(TR,
            OC_tnshps)

#join
CN_coll_cty_tnshp <-
  left_join(Coll_cty_CN,
            TR,
            by = "catalogNumber")

#save
write.csv(CN_coll_cty_tnshp,
          file = "CLEAN/CN_coll_cty_tnshp.csv",
          row.names = FALSE)

#county
Cty_coll_dist <-
  CN_coll_cty_tnshp %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)") %>%
  ungroup() %>%
  slice_max(num_spec,
            by = county,
            n = 1) %>%
  group_by(county,
           num_spec) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Cty_coll_dist,
          file = "CLEAN/Cty_coll_dist.csv",
          row.names = FALSE)

#township - has specimens only at the county level removed
#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist <-
  CN_coll_cty_tnshp %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist <-
  left_join(PLSS,
            Tnshp_coll_dist,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist,
          file = "CLEAN/Tnshp_coll_dist.csv",
          row.names = FALSE)

#map the 7 big individual collectors, both county and township level

#Brashier

Cty_coll_dist_Brashier <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Brashier")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_Brashier,
          file = "CLEAN/Cty_coll_dist_Brashier.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_Brashier <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Brashier")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_Brashier <-
  left_join(PLSS,
            Tnshp_coll_dist_Brashier,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_Brashier,
          file = "CLEAN/Tnshp_coll_dist_Brashier.csv",
          row.names = FALSE)

#JWT

Cty_coll_dist_JWT <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "John W.")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_JWT,
          file = "CLEAN/Cty_coll_dist_JWT.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_JWT <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "John W.")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_JWT <-
  left_join(PLSS,
            Tnshp_coll_dist_JWT,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_JWT,
          file = "CLEAN/Tnshp_coll_dist_JWT.csv",
          row.names = FALSE)

#DSA

Cty_coll_dist_DSA <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Derek")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_DSA,
          file = "CLEAN/Cty_coll_dist_DSA.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_DSA <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Derek")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_DSA <-
  left_join(PLSS,
            Tnshp_coll_dist_DSA,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_DSA,
          file = "CLEAN/Tnshp_coll_dist_DSA.csv",
          row.names = FALSE)

#RGK

Cty_coll_dist_RGK <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Koch")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_RGK,
          file = "CLEAN/Cty_coll_dist_RGK.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_RGK <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Koch")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_RGK <-
  left_join(PLSS,
            Tnshp_coll_dist_RGK,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_RGK,
          file = "CLEAN/Tnshp_coll_dist_RGK.csv",
          row.names = FALSE)

#RC

Cty_coll_dist_RC <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Castle")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_RC,
          file = "CLEAN/Cty_coll_dist_RC.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_RC <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Castle")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_RC <-
  left_join(PLSS,
            Tnshp_coll_dist_RC,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_RC,
          file = "CLEAN/Tnshp_coll_dist_RC.csv",
          row.names = FALSE)

#Romans

Cty_coll_dist_Romans <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Romans")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_Romans,
          file = "CLEAN/Cty_coll_dist_Romans.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_Romans <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Romans")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_Romans <-
  left_join(PLSS,
            Tnshp_coll_dist_Romans,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_Romans,
          file = "CLEAN/Tnshp_coll_dist_Romans.csv",
          row.names = FALSE)

#DWD

Cty_coll_dist_DWD <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Davidson")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_DWD,
          file = "CLEAN/Cty_coll_dist_DWD.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_DWD <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Davidson")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_DWD <-
  left_join(PLSS,
            Tnshp_coll_dist_DWD,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_DWD,
          file = "CLEAN/Tnshp_coll_dist_DWD.csv",
          row.names = FALSE)

####Task: Hlina distribution map####

#Brashier

Cty_coll_dist_PH <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Hlina, Paul")) %>%
  group_by(county,
           collectedBy) %>%
  summarize(n_distinct(catalogNumber)) %>%
  rename(num_spec = "n_distinct(catalogNumber)")

write.csv(Cty_coll_dist_PH,
          file = "CLEAN/Cty_coll_dist_PH.csv",
          row.names = FALSE)

#NOTE: run both dataframes together, otherwise will have warning about left join
Tnshp_coll_dist_PH <-
  CN_coll_cty_tnshp %>%
  filter(str_detect(collectedBy, "Hlina, Paul")) %>%
  filter(!is.na(t_num)) %>%
  group_by(t_num,
           t_dir,
           r_num,
           r_dir,
           collectedBy) %>%
  summarize(collected_specimens = n_distinct(catalogNumber))

Tnshp_coll_dist_PH <-
  left_join(PLSS,
            Tnshp_coll_dist_PH,
            by = c("TWP" = "t_num",
                   "RNG" = "r_num",
                   "DIR_ALPHA" = "r_dir")) %>%
  select(OBJECTID,
         TWP,
         t_dir,
         RNG,
         DIR_ALPHA,
         collectedBy,
         collected_specimens) %>%
  filter(!(is.na(collected_specimens))) %>%
  ungroup() %>%
  slice_max(collected_specimens,
            by = OBJECTID,
            n = 1) %>%
  group_by(OBJECTID,
           collected_specimens) %>%
  summarize(CollectedBy = str_c(collectedBy,
                                collapse = " & "))

write.csv(Tnshp_coll_dist_PH,
          file = "CLEAN/Tnshp_coll_dist_PH.csv",
          row.names = FALSE)
####Task: Create UpSet plot of top collectors####

#separate lists
#want CN of specimens collected by a person in a list
#then put all list into superlist

#load package needed

library(UpSetR)

#https://cran.r-project.org/web/packages/UpSetR/vignettes/basic.usage.html

#remove county from data frame because not needed

Coll_cty_CN <-
  Coll_cty_CN %>%
  select(-county)

#Brashier CN

Brashier_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Brashier") %>%
  pull(catalogNumber)

#JWT CN

JWT_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Thomson, John W., Jr.") %>%
  pull(catalogNumber)

#DSA CN

DSA_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Anderson, Derek S.") %>%
  pull(catalogNumber)

#RGK CN

RGK_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Koch, Rudy G.") %>%
  pull(catalogNumber)

#RC CN

RC_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Castle, R.") %>%
  pull(catalogNumber)

#Romans CN

Romans_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Romans") %>%
  pull(catalogNumber)

#DWD CN

DWD_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Davidson, Donald W.") %>%
  pull(catalogNumber)

#Everyone Else

EE_CN <-
  Coll_cty_CN %>%
  filter(collectedBy != "Brashier") %>%
  filter(collectedBy != "Thomson, John W., Jr.") %>%
  filter(collectedBy != "Anderson, Derek S.") %>%  
  filter(collectedBy != "Koch, Rudy G.") %>%
  filter(collectedBy != "Castle, R.") %>%  
  filter(collectedBy != "Romans") %>%  
  filter(collectedBy != "Davidson, Donald W.") %>%
  pull(catalogNumber)

#UpSet Plot List

UpSetList <- list(Brashier = Brashier_CN,
                  JWT = JWT_CN,
                  DSA = DSA_CN,
                  RGK = RGK_CN,
                  RC = RC_CN,
                  Romans = Romans_CN,
                  DWD = DWD_CN,
                  EE = EE_CN)

#upset plot
#set and intersection size both refer to number of specimens. the sizes of the intersections adds up to the set size.

upset(fromList(UpSetList),
      nsets = 8,
      order.by = "freq",
      text.scale = 3)

####Task: Investigating Brashier collecting with EE####

#remove county from data frame because not needed

Coll_cty_CN <-
  Coll_cty_CN %>%
  select(-county)

#Brashier CN

Brashier_CN <-
  Coll_cty_CN %>%
  filter(collectedBy == "Brashier") %>%
  pull(catalogNumber)

#pull records where Brashier is a collector, list other collectors

Brashier_w_EE <-
  Coll_cty_CN %>%
  filter(catalogNumber %in% Brashier_CN) %>%
  group_by(collectedBy) %>%
  summarize(Collected_With_Brashier = n())

BWEE_list <- unique(Brashier_w_EE$collectedBy)

Coll_size <-
  Coll_cty_CN %>%
  filter(collectedBy %in% BWEE_list) %>%
  group_by(collectedBy) %>%
  summarize(count_CS = n())  

BWEE_Coll_size <-
  merge(Brashier_w_EE,
        Coll_size,
        by = "collectedBy") %>%
  filter(collectedBy != "Brashier") %>%
  mutate(Collected_With_Others = count_CS - Collected_With_Brashier) %>%
  select(-count_CS) %>%
  pivot_longer(cols = c(Collected_With_Brashier,
                        Collected_With_Others),
               names_to = "category",
               values_to = "count") %>%
  mutate(category = gsub("_",
                         " ",
                         category))

ggplot(BWEE_Coll_size,
       aes(x = collectedBy,
           y = count,
           fill = category)) +
  geom_bar(stat = "identity",
           position = "stack") +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1),
        axis.text = element_text(size = 20),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 20),
        legend.title = element_blank(),
        legend.position = c(0.35, 0.75),
        legend.text = element_text(size = 20)) +
  labs(x = "Collected By",
       y = "Collection Size")

#Brashier is collecting with 27 other collectors!

####Task: stacked distribution####

#need year month day for specimens in Coll_cty_CN - temporary rewriting code here, but will not overwrite stored csv file

Coll_pst_sep_col <-
  SUWS_clean %>%
  select(catalogNumber,
         county,
         recordedBy,
         year,
         month,
         day) %>%
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

#separate collectors

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

#make collector group

Coll_cty_CN <-
  Coll_cty_CN %>%
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

Coll_cty_CN$coll_gr <-
  factor(Coll_cty_CN$coll_gr,
         levels = c("Anderson, Derek S.",
                    "Brashier",
                    "Castle, R.",
                    "Davidson, Donald W.",
                    "Koch, Rudy G.",
                    "Romans",
                    "Thomson, John W., Jr.",
                    "Other Collectors"))

#make graph - has top seven collectors plus everyone else by year
#is based on frequency of name, so not 1 to 1 with specimen number

ggplot(
  data = Coll_cty_CN,
  aes(x = year,
      fill = coll_gr)) +
  geom_vline(xintercept = 1940,
             col = "firebrick",
             size = 1,
             linetype = "dashed") +
  geom_histogram(binwidth = 1) +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 20),
        axis.title = element_text(size = 20),
        legend.text = element_text(size = 20),
        legend.title = element_blank(),
        legend.position = c(0.8, 0.75)) +
  labs(y = "Collector Contributions") +
  scale_x_continuous(breaks = seq(1905,
                                  2010,
                                  by = 10)) +
  scale_fill_brewer(palette = "Set1")

#make graph - above graph but by month, is also frequency of name

ggplot(
  data = Coll_cty_CN,
  aes(x = month,
      fill = coll_gr)) +
  geom_histogram(binwidth = 1) +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1),
        legend.title = element_blank()) +
  labs(x = "Month A Specimen Was Collected",
       y = "Frequency of Collection") +
  scale_x_continuous(breaks = seq(1,
                                  12,
                                  by = 1)) +
  scale_fill_brewer(palette = "Set1")

####Task: make line graph that displays cumulative collection growth - both year and month####

Coll_pst_sep_col <-
  SUWS_clean %>%
  select(catalogNumber,
         county,
         recordedBy,
         year,
         month,
         day) %>%
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

cumulative_by_year <-
  Coll_pst_sep_col %>%
  group_by(year) %>%
  summarize(year_count = n()) %>%
  mutate(cumulative_count = cumsum(year_count)) %>%
  mutate(percent_growth = 100 * (year_count / cumulative_count))

ggplot(
  cumulative_by_year,
  aes(x = year,
      y = cumulative_count)) +
  geom_vline(xintercept = 1940,
             col = "firebrick",
             size = 1,
             linetype = "dashed") +
  geom_line(size = 1.25) +
  geom_point(size = 3,
             aes(color = year_count)) +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1),
        axis.text = element_text(size = 20),
        axis.title = element_text(size = 20),
        legend.text = element_text(size = 20),
        legend.title = element_text(size = 20,
                                    vjust = 2.5,
                                    hjust = 0.5),
        legend.position = c(0.6, 0.75)) +
  labs(x = "",
       y = "Specimens") + 
  scale_x_continuous(breaks = seq(1905,
                                  2010,
                                  by = 10)) +
  scale_color_gradient(low = "blue",
                       high = "red",
                       name = "Specimens Added")

####Task: make phylogenetic tree####

#load packages - figure out which ones actually need

library(ggtree)
library(taxize)

#fix xanthoraceae T7_fam$family[T7_fam$family == "Xanthorrhoeaceae"] <- "Asphodelaceae"

SUWS_clean$family[SUWS_clean$family == "Xanthorrhoeaceae"] <- "Asphodelaceae"

familylist <-
  SUWS_clean %>%
  select(family) %>%
  distinct(family) %>%
  filter(family != "") %>%
  pull(family)

taxize_options(ncbi_sleep = 1)

classifications <- classification(familylist,
                                  db = "ncbi")

taxonomic_tree <- class2tree(classifications)

#wrangling coll_cty_CN so can get family data

Coll_pst_sep_col <-
  SUWS_clean %>%
  select(catalogNumber,
         recordedBy,
         family) %>%
  filter(family != "") %>%
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

Coll_cty_CN <- 
  rbind(Coll1,
        Coll2,
        Coll3)

#remove coll 1, coll2, coll3

rm(Coll1,
   Coll2,
   Coll3)

#trim collector column - somehow adding spaces before some names

Coll_cty_CN$collectedBy <-
  str_trim(Coll_cty_CN$collectedBy, side = "left")

#fix xanthoraceae

Coll_cty_CN$family[Coll_cty_CN$family == "Xanthorrhoeaceae"] <- "Asphodelaceae"

#subsetting out each collector

T7_fam <-
  Coll_cty_CN %>%
  mutate(collectedBy = case_when(
    collectedBy == "Brashier" ~ "Brashier",
    collectedBy == "Thomson, John W., Jr." ~ "JWT",
    collectedBy == "Anderson, Derek S." ~ "DSA",
    collectedBy == "Koch, Rudy G." ~ "RGK",
    collectedBy == "Castle, R." ~ "RC",
    collectedBy == "Romans" ~ "Romans",
    collectedBy == "Davidson, Donald W." ~ "DWD",
    TRUE ~ "OC")) %>% 
  group_by(family,
           collectedBy) %>%
  summarize(count = n())

JWT_fam <-
  T7_fam %>%
  filter(collectedBy == "JWT")

Brashier_fam <-
  T7_fam %>%
  filter(collectedBy == "Brashier")

DSA_fam <-
  T7_fam %>%
  filter(collectedBy == "DSA")

RGK_fam <-
  T7_fam %>%
  filter(collectedBy == "RGK")

RC_fam <-
  T7_fam %>%
  filter(collectedBy == "RC")

Romans_fam <-
  T7_fam %>%
  filter(collectedBy == "Romans")

DWD_fam <-
  T7_fam %>%
  filter(collectedBy == "DWD")

OC_fam <-
  T7_fam %>%
  filter(collectedBy == "OC")

All_fam <-
  Coll_cty_CN %>%
  mutate(collectedBy = case_when(
    collectedBy == "Brashier" ~ "Brashier",
    collectedBy == "Thomson, John W., Jr." ~ "JWT",
    collectedBy == "Anderson, Derek S." ~ "DSA",
    collectedBy == "Koch, Rudy G." ~ "RGK",
    collectedBy == "Castle, R." ~ "RC",
    collectedBy == "Romans" ~ "Romans",
    collectedBy == "Davidson, Donald W." ~ "DWD",
    TRUE ~ "OC")) %>%
  group_by(family) %>%
  summarize(count = n())

#now make trees for each

Brashier_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  Brashier_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("Brashier" = "red"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(20,
                                   40,
                                   60,
                                   80,
                                   100),
                        limits = c(0,
                                   100))

JWT_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  JWT_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("JWT" = "orange"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(20,
                                   40,
                                   60,
                                   80,
                                   100),
                        limits = c(0,
                                   100))

DSA_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  DSA_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("DSA" = "gold"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(20,
                                   40,
                                   60,
                                   80,
                                   100),
                        limits = c(0,
                                   100))

RGK_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  RGK_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("RGK" = "green"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(20,
                                   40,
                                   60,
                                   80,
                                   100),
                        limits = c(0,
                                   100))

RC_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  RC_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("RC" = "blue"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(20,
                                   40,
                                   60,
                                   80,
                                   100),
                        limits = c(0,
                                   100))

Romans_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  Romans_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("Romans" = "purple"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(20,
                                   40,
                                   60,
                                   80,
                                   100),
                        limits = c(0,
                                   100))

DWD_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  DWD_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("DWD" = "darkgreen"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(20,
                                   40,
                                   60,
                                   80,
                                   100),
                        limits = c(0,
                                   100)) 

OC_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  OC_fam +
  geom_tippoint(aes(
    color = collectedBy,
    size = count)) +
  geom_tiplab2(offset = 1.5) +
  theme(legend.position = c(1.2, 0.5)) +
  scale_color_manual(values = c("OC" = "darkblue"),
                     na.translate = FALSE) +
  scale_size_continuous(breaks = c(100,
                                   200,
                                   300,
                                   400),
                        limits = c(0,
                                   450))   

All_tree <- 
  ggtree(taxonomic_tree$phylo,
         layout = "circular") %<+%
  All_fam +
  geom_tippoint(aes(size = count),
                color = "darkred") +
  geom_tiplab2(offset = 1.5,
               size = 2) +
  theme(legend.position = c(1.1, 0.1),
        legend.title = element_blank(),
        legend.text = element_text(size = 20))
print(All_tree)


#show all the trees

print(Brashier_tree)
print(JWT_tree)
print(DSA_tree)
print(RGK_tree)
print(RC_tree)
print(Romans_tree)
print(DWD_tree)
print(OC_tree)
print(All_tree)

#save plots - pdf, 16.75 x 10.75 for now
#600 pixels tall