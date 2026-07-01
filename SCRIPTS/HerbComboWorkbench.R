#Lillian Holl
#HerbCombo - puts GEOG491 and ENSC381 projects in one place in prep for publication
#Workbench
#5/18/2026

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

####Task: Merge raw csv files into one big dataframe####

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
  ) %>%
  group_by(column_name,
           datatype) %>%
  count() %>%
  filter(n < 23)

#process
  #run comparison table to get list of what variables to check
  #run comparison table only through pivot longer to include dataset names
  #compare datasets and HerbCombo entries to see if data dropped

write.csv(comparison_table,
          file = "DATA/CLEAN/comparison_table.csv",
          row.names = FALSE)

HerbCombo_datatype_comparison <-
  HerbCombo %>%
  select(Source_File,
         accessRights) %>%
  group_by(Source_File,
           accessRights) %>%
  count()




HerbCombo <- list.files(path = "DATA/RAW",
                        pattern = "\\.csv$",
                        full.names = TRUE) %>%
  setNames(basename(.)) %>%
  lapply(read_csv,
         col_types = cols(.default = "c"),
         locale = locale(encoding = "latin1")) %>%
  bind_rows(.id = "Source_File")

####Task: Get one record for every record####

#duplicates could happen for two reasons - problem with database having two records or problem that the same record is coming from different databases

#three ways to look for duplicates

#unique occurenceID
#unique institutionCode/catalogNumber
#unique year/month/day/recordedBy/taxonID

#create first filter - unique occurenceID in this case

issues_initial <-
  HerbCombo %>%
  group_by(occurrenceID) %>%
  count()

#create answer datasets to unique occurrenceID filter and pull out identifying information

issues_Y <-
  issues_initial %>%
  filter(n == 1) %>%
  pull(occurence_ID)

issues_N <-
  issues_initial %>%
  filter(n > 1) %>%
  pull(occurrenceID)

#pulling NAs helps verify if records are being dropped from initial dataset (Y + N + NA = initial) - not necessary to pull with first filter since identifiable with is.na

# issues_NA <-
#   issues_initial %>%
#   filter(is.na(occurrenceID))

#create datasets filtered to contain records matching answer datasets

issues_Y_second <-
  HerbCombo %>%
  filter(occurenceID %in% issues_Y) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber) %>%
  count()

issues_N_second <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_N) %>%
  group_by(occurenceID,
           institutionCode,
           catalogNumber) %>%
  count()

issues_NA_second <-
  HerbCombo %>%
  filter(is.na(occurrenceID)) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber) %>%
  count()

#create answer datasets to unique ic/cn filter and pull out identifying information
#note on NA filtering - because all records were downloaded by collection name (and will have an institutionCode because of it), it will be catalogNumber that is NA in this step.

issues_Y_Y <-
  issues_Y_second %>%
  filter(n == 1) %>%
  select(-n)

issues_Y_N <-
  issues_Y_second %>%
  filter(n > 1) %>%
  select(-n)

issues_Y_NA <-
  issues_Y_second %>%
  filter(is.na(catalogNumber)) %>%
  select(-n)

issues_N_Y <-
  issues_N_second %>%
  filter(n == 1) %>%
  select(-n)

issues_N_N <-
  issues_N_second %>%
  filter(n > 1) %>%
  select(-n)

issues_N_NA <-
  issues_N_second %>%
  filter(is.na(catalogNumber)) %>%
  select(-n)

issues_NA_Y <-
  issues_NA_second %>%
  filter(n == 1) %>%
  select(-n)

issues_NA_N <-
  issues_NA_second %>%
  filter(n == 1) %>%
  select(-n)
  
issues_NA_NA <-
  issues_NA_second %>%
  filter(is.na(catalogNumber)) %>%
  select(-n)

#create third filter (year/month/day/recordedBy/taxonID in this case)

issues_Y_Y_third <-
  HerbCombo %>%
  filter(occurenceID %in% issues_Y_Y$occurrenceID &
           catalogNumber %in% issues_Y_Y$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()

issues_Y_N_third <-
  HerbCombo %>%
  filter(occurenceID %in% issues_Y_N$occurrenceID &
           catalogNumber %in% issues_Y_N$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()

issues_Y_NA_third <-
  HerbCombo %>%
  filter(occurenceID %in% issues_Y_NA$occurrenceID &
           is.na(catalogNumber)) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()  

issues_N_Y_third <-
  HerbCombo %>%
  filter(occurenceID %in% issues_N_Y$occurrenceID &
           catalogNumber %in% issues_N_Y$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()   

issues_N_N_third <-
  HerbCombo %>%
  filter(occurenceID %in% issues_N_N$occurrenceID &
           catalogNumber %in% issues_N_N$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()

issues_N_NA_third <-
  HerbCombo %>%
  filter(occurenceID %in% issues_N_Y$occurrenceID &
           is.na(catalogNumber)) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()

issues_NA_Y_third <-
  HerbCombo %>%
  filter(is.na(occurenceID) &
           catalogNumber %in% issues_NA_Y$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count() 

issues_NA_N_third <-
  HerbCombo %>%
  filter(is.na(occurenceID) &
           catalogNumber %in% issues_NA_N$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()

issues_NA_NA_third <-
  HerbCombo %>%
  filter(is.na(occurenceID) &
           is.na(catalogNumber)) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count()

#create answer datasets for unique year/month/day/recordedBy/taxonID

issues_Y_Y_Y <-
  issues_Y_Y_third %>%
  filter(n == 1) %>%
  select(-n)

issues_Y_Y_N <-
  issues_Y_Y_third %>%
  filter(n > 1) %>%
  select(-n)  

issues_Y_Y_NA <-
  issues_Y_Y_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  select(-n)
  

issues_Y_N_Y <-
  issues_Y_N_third %>%
  filter(n == 1) %>%
  select(-n)

issues_Y_N_N <-
  issues_Y_N_third %>%
  filter(n > 1) %>%
  select(-n)
  
issues_Y_N_NA <-
  issues_Y_N_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  select(-n)


issues_Y_NA_Y <-
  issues_Y_NA_third %>%
  filter(n == 1) %>%
  count(-n)
  
issues_Y_NA_N <-
  issues_Y_NA_third %>%
  filter(n > 1) %>%
  count(-n)
  
issues_Y_NA_NA <-
  issues_Y_NA_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  count(-n)


issues_N_Y_Y <-
  issues_N_Y_third %>%
  filter(n == 1) %>%
  select(-n)
  
issues_N_Y_N <-
  issues_N_Y_third %>%
  filter(n > 1) %>%
  select(-n)
  
issues_N_Y_NA <-
  issues_N_Y_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  count(-n)
  
  
issues_N_N_Y <-
  issues_N_N_third %>%
  filter(n == 1) %>%
  select(-n)
  
issues_N_N_N <-
  issues_N_N_third %>%
  filter(n > 1) %>%
  select(-n)
  
issues_N_N_NA <-
  issues_N_N_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  count(-n)


issues_N_NA_Y <-
  issues_N_NA_third %>%
  filter(n == 1) %>%
  select(-n)

issues_N_NA_N <-
  issues_N_NA_third %>%
  filter(n > 1) %>%
  select(-n)
  
issues_N_NA_NA <-
  issues_N_NA_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  count(-n)
  

issues_NA_Y_Y <-
  issues_NA_Y_third %>%
  filter(n == 1) %>%
  select(-n)
  
issues_NA_Y_N <-
  issues_NA_Y_third %>%
  filter(n > 1) %>%
  select(-n)
  
issues_NA_Y_NA <-
  issues_NA_Y_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  count(-n)

  
issues_NA_N_Y <-
  issues_NA_N_third %>%
  filter(n == 1) %>%
  select(-n)

issues_NA_N_N <-
  issues_NA_N_third %>%
  filter(n > 1) %>%
  select(-n)

issues_NA_N_NA <-
  issues_NA_N_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  count(-n)

  
issues_NA_NA_Y <-
  issues_NA_NA_third %>%
  filter(n == 1) %>%
  select(-n)

issues_NA_NA_N <-
  issues_NA_NA_third %>%
  filter(n > 1) %>%
  select(-n)
  
issues_NA_NA_NA <-
  issues_NA_NA_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID)) %>%
  count(-n) 

#tasks for tomorrow
  #figure out issue with UWL not loading correctly  
  #run code line by line, do math to make sure not dropping records
  #make decisions on what can go into dataset for analysis
  #recycle code to filter out columns for file size
  #finish annotating flowchart







