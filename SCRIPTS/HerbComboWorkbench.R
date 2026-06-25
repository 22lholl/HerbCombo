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

####Task: Compare Data from different Hosts####

#Thought process

#add host column to data before merging
#merge data into one big dataframe
#sort by collection ID
#keep the records that are the most complete

####Task: Merge into one big dataframe####

HerbCombo <- list.files(path = "DATA/RAW",
                        pattern = "\\.csv$",
                        full.names = TRUE) %>%
  lapply(read_csv, 
         col_types = cols(.default = col_character()),
         locale = locale(encoding = "latin1")) %>%
  bind_rows()



















