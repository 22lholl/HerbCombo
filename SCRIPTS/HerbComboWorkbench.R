#Lillian Holl
#HerbCombo - puts GEOG491 and ENSC381 projects in one place in prep for publication
#Workbench
#5/18/2026

#what checks did I do for SUWS to be cleaned?

#check if all NAs in a column
#checking if there is the same entry in every column
#removing columns of little value to analysis
#looking for duplicate catalog numbers
#look for misspellings of collector names
#make decision about records with incomplete geographic or temporal information
#separating out and attaching collectors in individual columns

#What are additional checks I should do when dealing with multiple herbaria and multiple download sources for herbaria?

#compare datasets between different sources and determine which records to use
#write code so it is easy to add chopped up large herbaria datasets to be assembled in R for analysis
#look for any dropped years in the larger datasets that are chopped up by year

####Task: Merge into one big dataframe####

HerbCombo <- list.files(path = "DATA/RAW",
                        pattern = "\\.csv$",
                        full.names = TRUE) %>%
  lapply(read_csv, 
         col_types = cols(.default = col_character()),
         locale = locale(encoding = "latin1")) %>%
  bind_rows()

HerbCombo <- list.files(path = "DATA/RAW",
                        pattern = "\\.csv$",
                        full.names = TRUE) %>%
  setNames(basename(.)) %>%
  lapply(read_csv, 
         col_types = cols(.default = col_character()),
         locale = locale(encoding = "latin1")) %>%
  bind_rows(.id = "Source_File")

####Task: Compare Data from different Hosts + look for duplicates####

#Thought process

#sort by collection ID - look at console output to see if more than one listed
#If only one listed, put into new mega dataset and remove from old
#If more than one, look at records - try to keep all of one dataset together, but also go for the most complete data

lkg_fr_dups <- 
  HerbCombo %>% 
  group_by(Source_File,
           institutionCode, 
           catalogNumber) %>% 
  count() %>% 
  filter(n > 1)

#seems like if 2 with same catalogNumber from dataset and same institution, might be determination history error? those would require more investigation...

#in any case, can deal with records that have no catalog number first. 

issues <-
  HerbCombo %>%
  filter(institutionCode == "CONCOL",
         catalogNumber == "CONC004877" | catalogNumber == "CONC004879" | catalogNumber == "CONC004885")

issues <-
  HerbCombo %>%
  filter(institutionCode == "CSBSJU",
         is.na(catalogNumber) == TRUE) %>%
  group_by(year,
           month,
           day,
           recordedBy,
           taxonID)















