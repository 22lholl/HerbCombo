#Lillian Holl
#HerbCombo - puts GEOG491 and ENSC381 projects in one place in prep for publication
#Archive
#5/18/2026

####SepPeak - SUWS to SUWS_clean - column and row clean-up####

#SUWS WisFlora, unaltered
SUWS <- read.csv("DATA/RAW/occurrence_data_20250922105936_DarwinCore.csv")

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
          file = "DATA/CLEAN/SUWS_clean.csv",
          row.names = FALSE)

#removes extraneous data and values from environment

rm(list = setdiff(ls(), "SUWS_clean"))

####Figure Catalog####

#single hastag on individual figure means figure was made outside RStudio
##double hastag on individual figure means it was made with R code

#important to remember for maps - not all records have township data in easily available form, while county data is fairly standard

#tend to use collection/contribution interchangeably?

#GEOG 491


#DRAFTS (wrangling script)

  #contributed specimens vs. number of collectors, contributed specimens < 125 - Draft Figures code, GEOG 491
      #same shape as graph with whole collection (more collectors who make few collections), but has less outliers/people over representing collection?

  #histogram of individuals contributing less than 125 specimens - Draft Figures code, GEOG 491
      #terrible visual, but important point about representing small work in collections?

  #histogram of individuals contributing 1 or 2 specimens - Draft Figures code, GEOG 491
      #terrible visual, but important point about representing small work in collections?

  #cumulative collection growth - Draft Figures code, GEOG 491
      #Plateau from founding in 1940s, 1950s, 


#POLISHED (were exported at some point)

  #Conceptual model of collection and digitization - OLD > HerbGIS_Prj, final paper
      #plants in the world > collection > herbarium > digitization > database

  #Venn diagram of abies balsamea data base records & physical specimens - OLD > HerbGIS_Prj, final paper
      #database deals with small slice of what may have - only WI specimens, couldn't locate all that had database records, etc.

  ##contributed specimens vs. number of collectors (who had made that many contributions) - OLD > HerbGIS_Prj, final paper
      #red line on 125 contributions marks approximate halfway pt of top seven and rest of collectors
      #just seven made up half of database

  ##top seven collectors vs. the number of contributions made

  #Top seven collectors range maps, county (statewide) - OLD > HerbGIS_Prj > HG_AP > MAPS > PRESENTATION MAPS (also OLD > HerbGIS_Prj, final paper)
      #all maps show a concentration in Douglas cty in some form
      #some collectors more widespread than others

  #collectors per county (statewide) - OLD > HerbGIS_Prj > HG_AP > MAPS > PRESENTATION MAPS
      #all maps show a concentration in Douglas cty in some form
      #not all counties collected in statewide

  #collectors per township (statewide) - OLD > HerbGIS_Prj > HG_AP > MAPS > PRESENTATION MAPS
      #finer detail helps point out that often only a few townships reps a cty, except for well sampled counties like Douglas and Bayfield?
      #not all records have township, unlike county

  #specimens per county (statewide) - OLD > HerbGIS_Prj > HG_AP > MAPS > PRESENTATION MAPS

  #specimens per township (statewide) - OLD > HerbGIS_Prj > HG_AP > MAPS > PRESENTATION MAPS

  ##collector contributions by year (aka stacked distribution) - OLD > HerbGIS_Prj, final paper
      #legend has top seven plus other collectors, red dashed line shows when collection founded
      #see peaks in certain years coinciding with when top collectors contributing, but also small collectors quite active
  
  ##UpSet plot (set intersection plot) - OLD > HerbGIS_Prj, final paper
      #see network of who's collecting (or not collecting) with who

  ##Brashier's co-collectors - OLD > HerbGIS_Prj, final paper
      #majority of everyone he collected with, those were their only contributions

  ##Phylogenetic Tree - Whole collection, by family -  OLD > HerbGIS_Prj > HG_R > PLOTS > Drafts

  ##Phylogenetic Tree - whole collection (blank), by family - OLD > HerbGIS_Prj > HG_R > PLOTS > Drafts

  ##Phylogenetic Tree - top seven and other collectors individual graphs, by family - OLD > HerbGIS_Prj > HG_R > PLOTS > Drafts
      #can definitely see taxonomic bias in that some families are collected more than others
      #also, top collectors will collect different things but are prone to same bias?
      #counts in taxonomic categories not standardized, just raw counts - bias still show up if standardized somehow?

#ENSC 381

#DRAFTS



#POLISHED (exported at some point)

  #conceptual Model of Collector Role Biases - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #introduces environmental diff in collector practices

  #Specimens by month - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #breaks out top seven and all other collectors, shows july and sep peak

  #Contributions by month - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #breaks out top seven and all other collectors, shows july and sep peak

  #contributions made by collectors in September - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #orders all collectors from most to least contributions, highlights approximate halfway point with red line

  #Top 5 of 7 that contributed in September - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #monthly graphs of contributions with September highlighted - none have peaks in september

  #Top 18 contributors in September - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #names the 18 and gives how many contributions they had, one of the top 7 overall doesn't even make it to here

  #Phylogenetic Tree, orders, July Contributions - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #flowering orders more popular in summer, both by number and being collected at all

  #Phylogenetic Tree, orders, September contributions - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #non-flowering more popular when considering less angiosperm orders collected, but still have trend of major angiosperm orders having the most collections

  #comparison of July and September contributions, broken out by July vs. September and top 7 vs. other collectors - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #shows that top 7 barely collect in september, other collectors about same in September

  #Kadmon Index, WI counties statewide - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf

  #Kadmon Index, counties in WI's northern region - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf

  #Kadmon Index, townships in WI's northern region - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #has error - labeled as counties but is actually townships

  #Kadmon Index, townships in Douglas county - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf

####Draft Figures from Figure Catalog####
  ####GEOG 491####
    ####Task: histogram of who collected how much (MODIFIED)####

#Coll_cty_CN - has catalogNumber, county collected in, and name of collector. Specimens may be repeated if there were two or more collectors listed
Coll_cty_CN <- read.csv("DATA/CLEAN/from_OLD/Coll_cty_CN.csv")

#histo object using Coll_cty_CN

histo <-
  Coll_cty_CN %>%
  group_by(collectedBy) %>%
  count(collectedBy)

#same thing but with below 125 for number of contributed specimens

ggplot(subset(histo,
              n < 125),
       aes(x = n)) +
  geom_histogram() +
  labs(title = "Contributed Specimens compared to Number of Collectors (who contribute 125 specimens or less)",
       x = "Number of Contributed Specimens",
       y = "Number of Collectors")


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



    ####Task: make line graph that displays cumulative collection growth - both year and month (UNMODIFIED)####

#SUWS_clean
SUWS_clean <- read.csv("DATA/CLEAN/SUWS_clean.csv")

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

  ####ENSC 381####