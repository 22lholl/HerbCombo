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

  ##daily histo - Draft Figures code, ENSC 381
    #has bar graph of 365 days and daily count of how much contributed and/or collected on that day, with September and July highlighted to emphasize that even daily seems higher than normal

  ##collection size of september collectors, collectors with less than 150 and more than 150 - Draft Figures code, ENSC 381
    #displays collection size of specifically collectors in September in order of least to most
    #does for both more than 150 contributions, which is 5 of the top 7 that contributed in September (if contributed in September, whole collection across entire year feeds in), as well as less than 150 contributions, which is everybody else
    
  ##dotplots - Draft Figures code, ENSC 381
    #compares July vs. September and then Angiosperm vs. Nonflowering on an xy plane
    #almost an exponential curve where non top 7 are generally in lower left but top 7 in upper right

#POLISHED (exported at some point)

  #conceptual Model of Collector Role Biases - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #introduces environmental diff in collector practices

  ##Specimens by month - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #breaks out top seven and all other collectors, shows july and sep peak

  ##Contributions by month - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #breaks out top seven and all other collectors, shows july and sep peak

  ##contributions made by collectors in September - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #orders all collectors from most to least contributions, highlights approximate halfway point with red line

  ##Top 5 of 7 that contributed in September - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #monthly graphs of contributions with September highlighted - none have peaks in september

  ##Top 18 contributors in September - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #names the 18 and gives how many contributions they had, one of the top 7 overall doesn't even make it to here

  ##Phylogenetic Tree, orders, July Contributions - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #flowering orders more popular in summer, both by number and being collected at all

  ##Phylogenetic Tree, orders, September contributions - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #non-flowering more popular when considering less angiosperm orders collected, but still have trend of major angiosperm orders having the most collections

  ##comparison of July and September contributions, broken out by July vs. September and top 7 vs. other collectors - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #shows that top 7 barely collect in september, other collectors about same in September

  #Kadmon Index, WI counties statewide - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf

  #Kadmon Index, counties in WI's northern region - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf

  #Kadmon Index, townships in WI's northern region - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf
      #has error - labeled as counties but is actually townships

  #Kadmon Index, townships in Douglas county - OLD > ENSC381 > SepPeak > MARKDOWN, research paper pdf

####Draft Figures from Figure Catalog####
  ####GEOG 491####
    ####Task: histogram of who collected how much (MODIFIED, only pulled one graph that was missing)####

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
    ####Task: make daily histo (UNMODIFIED)####

#SUWS where only primary collectors are attached to a record (single entry for a specimen)
SUWS_primary <- read.csv("DATA/CLEAN/from_OLD/SUWS_primary.csv")

#SUWS where collectors are associated with their record (specimens appear more than once if there was more than one collector)
SUWS_sep_collectors <- read.csv("DATA/CLEAN/from_OLD/SUWS_sep_collectors.csv")

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

    ####Task: Display the collection size of September collectors (MODIFIED, only pulled two graphs that was missing)####

#SUWS containing only those who have made contributions in September
SUWS_Sept_coll <- read.csv("DATA/CLEAN/from_OLD/SUWS_Sept_coll.csv")

Sept_Coll_size <-
  SUWS_Sept_coll %>%
  group_by(collectedBy) %>%
  count(collectedBy)

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

####Task: Prep data for Paired Wilcox, assess for normality, Plot comparisons (UNMODIFIED)####

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



####Task: split Bell MN into manageable chunks because unable to do at time of download####

#load data

Bell_MN <- read.csv("DATA/RAW_OG/occurrences.csv",
                    fileEncoding = "latin1")

#split data

Bell_MN_year_na <- Bell_MN %>% filter(is.na(year))

Bell_MN_pre1946 <- Bell_MN %>% filter(year <= 1945)

Bell_MN_1946_1985 <- Bell_MN %>% filter(year >= 1946 &
                                          year < 1986)

Bell_MN_1986_2000 <- Bell_MN %>% filter(year >= 1986 &
                                          year < 2001)

Bell_MN_post2000 <- Bell_MN %>% filter(year > 2000)

#export data

write.csv(Bell_MN_year_na,
          "DATA/RAW_OG/DarwinCore_2026-06-22_230410_Bell_MN_year_na.csv",
          row.names = FALSE)

write.csv(Bell_MN_pre1946,
          "DATA/RAW_OG/DarwinCore_2026-06-22_230410_Bell_MN_pre1946.csv",
          row.names = FALSE)

write.csv(Bell_MN_1946_1985,
          "DATA/RAW_OG/DarwinCore_2026-06-22_230410_Bell_MN_1946_1985.csv",
          row.names = FALSE)

write.csv(Bell_MN_1986_2000,
          "DATA/RAW_OG/DarwinCore_2026-06-22_230410_Bell_MN_1986_2000.csv",
          row.names = FALSE)

write.csv(Bell_MN_post2000,
          "DATA/RAW_OG/DarwinCore_2026-06-22_230410_Bell_MN_post2000.csv",
          row.names = FALSE)

####Task: split Consortium MN####

#load data

Consortium_MN <- read.csv("DATA/RAW_OG/occurrences_2026_06_21_212202_DarwinCore_Consortium_MIN.csv",
                          fileEncoding = "latin1")

#split data

Consortium_MN_year_na <- Consortium_MN %>% filter(is.na(year))

Consortium_MN_pre1946 <- Consortium_MN %>% filter(year <= 1945)

Consortium_MN_1946_1990 <- Consortium_MN %>% filter(year >= 1946 &
                                                      year < 1991)

Consortium_MN_post1990 <- Consortium_MN %>% filter(year > 1990)

#export data

write.csv(Consortium_MN_year_na,
          "DATA/RAW_OG/DarwinCore_2026_06_21_212202_Consortium_MN_year_na.csv",
          row.names = FALSE)

write.csv(Consortium_MN_pre1946,
          "DATA/RAW_OG/DarwinCore_2026_06_21_212202_Consortium_MN_pre1946.csv",
          row.names = FALSE)

write.csv(Consortium_MN_1946_1990,
          "DATA/RAW_OG/DarwinCore_2026_06_21_212202_Consortium_MN_1946_1990.csv",
          row.names = FALSE)

write.csv(Consortium_MN_post1990,
          "DATA/RAW_OG/DarwinCore_2026_06_21_212202_Consortium_MN_post1990.csv",
          row.names = FALSE)

####Task: split Consortium WIS####

#load data

Consortium_WIS <- read.csv("DATA/RAW_OG/occurrences_2026_06_21_220149_DarwinCore_Consortium_WIS.csv",
                           fileEncoding = "latin1")

#split data

Consortium_WIS_year_na <- Consortium_WIS %>% filter(is.na(year))

Consortium_WIS_pre1940 <- Consortium_WIS %>% filter(year <= 1939)

Consortium_WIS_1940_1960 <- Consortium_WIS %>% filter(year >= 1940 &
                                                        year < 1961)

Consortium_WIS_1961_1976 <- Consortium_WIS %>% filter(year >= 1961 &
                                                        year < 1977)

Consortium_WIS_1977_2000 <- Consortium_WIS %>% filter(year >= 1977 &
                                                        year < 2001)

Consortium_WIS_post2000 <- Consortium_WIS %>% filter(year > 2000)

#export data

write.csv(Consortium_WIS_year_na,
          "DATA/RAW_OG/DarwinCore_2026_06_21_220149_Consortium_WIS_year_na.csv",
          row.names = FALSE)

write.csv(Consortium_WIS_pre1940,
          "DATA/RAW_OG/DarwinCore_2026_06_21_220149_Consortium_WIS_pre1940.csv",
          row.names = FALSE)

write.csv(Consortium_WIS_1940_1960,
          "DATA/RAW_OG/DarwinCore_2026_06_21_220149_Consortium_WIS_1940_1960.csv",
          row.names = FALSE)

write.csv(Consortium_WIS_1961_1976,
          "DATA/RAW_OG/DarwinCore_2026_06_21_220149_Consortium_WIS_1961_1976.csv",
          row.names = FALSE)

write.csv(Consortium_WIS_1977_2000,
          "DATA/RAW_OG/DarwinCore_2026_06_21_220149_Consortium_WIS_1977_2000.csv",
          row.names = FALSE)

write.csv(Consortium_WIS_post2000,
          "DATA/RAW_OG/DarwinCore_2026_06_21_220149_Consortium_WIS_post2000.csv",
          row.names = FALSE)
####Notes: list of what to check on data and what makes a duplicated record####

#what checks did I do for SUWS to be cleaned?

#check if all NAs in a column
#checking if there is the same entry in every column
#removing columns of little value to analysis (trying to reduce file size as much as possible)
#look for misspellings of collector names
#separating out and attaching collectors in individual columns

#looking for duplicate catalog numbers
#make decision about records with incomplete geographic or temporal information

#What are additional checks I should do when dealing with multiple herbaria and multiple download sources for herbaria?

#compare datasets between different sources and determine which records to use
#write code so it is easy to add chopped up large herbaria datasets to be assembled in R for analysis
#look for any dropped years in the larger datasets that are chopped up by year

#what constitutes a duplicate?

#same day, same plant, same people

####Task: check data types, get one big unfiltered dataset####

#finding which variables are tripping up HerbCombo and giving warning message

# 1. Define the path to your folder
folder_path <- "DATA/RAW/"

# 2. Get a list of all CSV files in that folder
file_list <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)

# 3. Loop through files and assign each to its own data frame
for (file in file_list) {
  # Extract the clean file name without the path and extension to use as the variable name
  obj_name <- tools::file_path_sans_ext(basename(file))
  
  # Read the CSV and assign it to that name
  assign(obj_name, read.csv(file,
                            fileEncoding = "latin1"))
}

#delete objects form environment that aren't dataframes
rm(file)
rm(file_list)
rm(folder_path)
rm(obj_name)

library(janitor)

# 2. Put your data frames into a named list
df_list <- list(mget(ls()))

# 3. Compare the columns
comparison_table <- 
  compare_df_cols(df_list[[1]]) %>%
  pivot_longer(
    cols = !c(column_name),      # Excludes these columns from pivoting
    names_to = "csv_name",            # Name of the new category column
    values_to = "datatype"            # Name of the new data values column
  )

#can export csv and open up in google sheets or excel
# write.csv(comparison_table,
#           file = "DATA/CLEAN/comparison_table.csv",
#           row.names = FALSE)

#process
#run comparison table to get list of what variables to check
#compare datasets and HerbCombo entries to see if data dropped - look particularly for if labeled character in comparison table when shouldn't be/other datasets aren't

#get one big dataset

HerbCombo <- list.files(path = "DATA/RAW",
                        pattern = "\\.csv$",
                        full.names = TRUE) %>%
  setNames(basename(.)) %>%
  lapply(read_csv,
         col_types = cols(.default = "c"),
         locale = locale(encoding = "latin1")) %>%
  bind_rows(.id = "Source_File")

HerbCombo_datatype_comparison <-
  HerbCombo %>%
  select(Source_File,
         accessRights) %>%
  group_by(Source_File,
           accessRights) %>%
  count()

#once satisfied, remove all extraneous datasets

rm(list = setdiff(ls(),
                  "HerbCombo"))

####Task: filter by unique occurenceID (1/3)####

#create first filter - unique occurenceID in this case

issues_initial <-
  HerbCombo %>%
  group_by(occurrenceID) %>%
  count()

#create answer datasets to unique occurrenceID filter and pull out identifying information

issues_Y <-
  issues_initial %>%
  filter(n == 1)

issues_N <-
  issues_initial %>%
  filter(n > 1,
         !(is.na(occurrenceID)))

#pulling NAs helps verify if records are being dropped from initial dataset (Y + N + NA = initial) - not necessary to pull with first filter since identifiable with is.na

# issues_NA <-
#   issues_initial %>%
#   filter(is.na(occurrenceID))

#remove initial dataset

rm(issues_initial)

####Task: filter by unique institutionCode/catalogNumber (2/3)####

#create datasets filtered to contain records matching answer datasets

issues_Y_second <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_Y$occurrenceID) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber) %>%
  count()

issues_N_second <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_N$occurrenceID) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber) %>%
  count()

#note: because issues N pulls multiple occurence id, the issues N second dataset will be larger because it is pulling all records but adding institution code and catalog Number as additonal qualifiers.

#a test to verify if issues N second has pulled the correct amount of records is to add up the count column from issues N and then from issues N second. if they equal each other, then they pulled the right records.

# sum(issues_N$n)
# sum(issues_N_second$n)

issues_NA_second <-
  HerbCombo %>%
  filter(is.na(occurrenceID)) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber) %>%
  count()

#remove datasets

rm(issues_Y)
rm(issues_N)

#create answer datasets to unique ic/cn filter and pull out identifying information
#note on NA filtering - because all records were downloaded by collection name (and will have an institutionCode because of it), it will be catalogNumber that is NA in this step.

issues_Y_Y <-
  issues_Y_second %>%
  filter(n == 1,
         !(is.na(catalogNumber)))

issues_Y_N <-
  issues_Y_second %>%
  filter(n > 1,
         !(is.na(catalogNumber)))

issues_Y_NA <-
  issues_Y_second %>%
  filter(is.na(catalogNumber))



issues_N_Y <-
  issues_N_second %>%
  filter(n == 1,
         !(is.na(catalogNumber)))

issues_N_N <-
  issues_N_second %>%
  filter(n > 1,
         !(is.na(catalogNumber)))

issues_N_NA <-
  issues_N_second %>%
  filter(is.na(catalogNumber))

#checking that n added up across all three datasets equals what was in issues n second to ensure all records filtered

# sum(issues_N_Y$n,
#     issues_N_N$n,
#     issues_N_NA$n)
# sum(issues_N_second$n)



issues_NA_Y <-
  issues_NA_second %>%
  filter(n == 1,
         !(is.na(catalogNumber)))

issues_NA_N <-
  issues_NA_second %>%
  filter(n > 1,
         !(is.na(catalogNumber)))

issues_NA_NA <-
  issues_NA_second %>%
  filter(is.na(catalogNumber))

#checking that n adds up across all three datasets

# sum(issues_NA_Y$n,
#      issues_NA_N$n,
#      issues_NA_NA$n)
# sum(issues_NA_second$n)

#remove datasets

rm(issues_Y_second)
rm(issues_N_second)
rm(issues_NA_second)