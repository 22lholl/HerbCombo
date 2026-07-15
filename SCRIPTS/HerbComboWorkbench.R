#Lillian Holl
#HerbCombo - puts GEOG491 and ENSC381 projects in one place in prep for publication
#Workbench
#5/18/2026

####Task: filter by unique year/month/day/recordedBy/taxonID####

#have to pull institution code and occurence ID because have not yet been uniquely identified - otherwise will pull occurence IDs from other instituions not in list

#create third filter (year/month/day/recordedBy/taxonID in this case)

issues_Y_Y_third <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_Y_Y$occurrenceID,
         institutionCode %in% issues_Y_Y$institutionCode,
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

#issues Y N is empty for this particular dataset and so does not need to be run

# issues_Y_N_third <-
#   HerbCombo %>%
#   filter(occurenceID %in% issues_Y_N$occurrenceID,
#          institutionCode %in% issues_Y_N$institutionCode,
#          catalogNumber %in% issues_Y_N$catalogNumber) %>%
#   group_by(occurrenceID,
#            institutionCode,
#            catalogNumber,
#            year,
#            month,
#            day,
#            recordedBy,
#            taxonID) %>%
#   count()

issues_Y_NA_third <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_Y_NA$occurrenceID,
         institutionCode %in% issues_Y_NA$institutionCode,
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
  filter(occurrenceID %in% issues_N_Y$occurrenceID,
         institutionCode %in% issues_N_Y$institutionCode,
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
  filter(occurrenceID %in% issues_N_N$occurrenceID,
         institutionCode %in% issues_N_N$institutionCode,
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
  filter(occurrenceID %in% issues_N_NA$occurrenceID,
         institutionCode %in% issues_N_NA$institutionCode,
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
  filter(is.na(occurrenceID),
         institutionCode %in% issues_NA_Y$institutionCode,
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
  filter(is.na(occurrenceID),
         institutionCode %in% issues_NA_Y$institutionCode,
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
  filter(is.na(occurrenceID),
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

#remove datasets to declutter environment

rm(issues_Y_Y,
   issues_Y_N,
   issues_Y_NA,
   issues_N_Y,
   issues_N_N,
   issues_N_NA,
   issues_NA_Y,
   issues_NA_N,
   issues_NA_NA)

#create answer datasets for unique year/month/day/recordedBy/taxonID

issues_Y_Y_Y <-
  issues_Y_Y_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

issues_Y_Y_N <-
  issues_Y_Y_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

issues_Y_Y_NA <-
  issues_Y_Y_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))
  


#YN datasets not needed for HerbCombo

# issues_Y_N_Y <-
#   issues_Y_N_third %>%
#   filter(n == 1)
# 
# issues_Y_N_N <-
#   issues_Y_N_third %>%
#   filter(n > 1)
#   
# issues_Y_N_NA <-
#   issues_Y_N_third %>%
#   filter(is.na(year) |
#            is.na(month) |
#            is.na(day) |
#            is.na(recordedBy) |
#            is.na(taxonID))



issues_Y_NA_Y <-
  issues_Y_NA_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_Y_NA_N <-
  issues_Y_NA_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_Y_NA_NA <-
  issues_Y_NA_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))



issues_N_Y_Y <-
  issues_N_Y_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_N_Y_N <-
  issues_N_Y_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_N_Y_NA <-
  issues_N_Y_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))
  


issues_N_N_Y <-
  issues_N_N_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_N_N_N <-
  issues_N_N_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_N_N_NA <-
  issues_N_N_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))

#check that numbers match

sum(issues_N_N_third$n)
sum(issues_N_N_Y$n,
    issues_N_N_N$n,
    issues_N_N_NA$n)

sum(issues_N_N_Y$n)

issues_N_NA_Y <-
  issues_N_NA_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

issues_N_NA_N <-
  issues_N_NA_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_N_NA_NA <-
  issues_N_NA_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))



issues_NA_Y_Y <-
  issues_NA_Y_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

issues_NA_Y_N <-
  issues_NA_Y_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_NA_Y_NA <-
  issues_NA_Y_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))
  


issues_NA_N_Y <-
  issues_NA_N_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

issues_NA_N_N <-
  issues_NA_N_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

issues_NA_N_NA <-
  issues_NA_N_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))
  


issues_NA_NA_Y <-
  issues_NA_NA_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

issues_NA_NA_N <-
  issues_NA_NA_third %>%
  filter(n > 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))
  
issues_NA_NA_NA <-
  issues_NA_NA_third %>%
  filter(is.na(year) |
           is.na(month) |
           is.na(day) |
           is.na(recordedBy) |
           is.na(taxonID))

#remove datasets for decluttering

rm(issues_Y_Y_third,
   )

#remove datasets that HerbCombo project does not need in merging

rm(issues_Y_Y_N,
   issues_Y_Y_NA,
   )

####Task: see what in determination history is causing uniqueness in year/month/day/recordedBy/taxonID####

issues_N_N_Y_ymd <-
  issues_N_N_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           recordedBy,
           taxonID) %>%
  count()  

issues_N_N_Y_recordedBy <-
  issues_N_N_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           taxonID) %>%
  count()

issues_N_N_Y_taxonID <-
  issues_N_N_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy) %>%
  count()  

#taxonID comes up with least observations, aka more instances have differences in taxon ID because they collapse into less observations.

#finding unique taxon ID

issues_N_N_Y_taxonID_Y <-
  issues_N_N_Y_taxonID %>%
  filter(n == 1)

issues_N_N_Y_taxonID_N <-
  issues_N_N_Y_taxonID %>%
  filter(n > 1)

#regrouping with modified

modified <-
  issues_N_N_Y %>%
  left_join(HerbCombo %>% select(occurrenceID,
                                 institutionCode,
                                 catalogNumber,
                                 year,
                                 month,
                                 day,
                                 recordedBy,
                                 taxonID,
                                 modified),
            by = c("occurrenceID",
                   "institutionCode",
                   "catalogNumber",
                   "year",
                   "month",
                   "day",
                   "recordedBy",
                   "taxonID"))  %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           modified) %>%
  count()
  
modified_Y <-
  modified %>%
  filter(n == 1)

modified_N <-
  modified %>%
  filter(n > 1)
  
#get latest modified record when modified is unique

modified_Y_latest <-
  modified_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy) %>%
  slice_max(order_by = modified,
            n = 1)
  
####Task: work on nnn####

#see if source file the issue

source_file_issue <-
  issues_N_N_N %>%
  left_join(HerbCombo %>% select(occurrenceID,
                                 institutionCode,
                                 catalogNumber,
                                 year,
                                 month,
                                 day,
                                 recordedBy,
                                 taxonID,
                                 modified),
            by = c("occurrenceID",
                   "institutionCode",
                   "catalogNumber",
                   "year",
                   "month",
                   "day",
                   "recordedBy",
                   "taxonID"))  %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID,
           modified) %>%
  count()

source_file_issue_Y <-
  source_file_issue %>%
  filter(n == 1)

source_file_issue_N <-
  source_file_issue %>%
  filter(n > 1)  

source_file_issue_Y_latest <-
  source_file_issue_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  slice_max(order_by = modified,
            n = 1)
  
####Task: deal with nnna####

unique_issues_N_N_NA <-
  issues_N_N_NA %>%
  filter(n == 1)

non_unique_issues_N_N_NA <-
  issues_N_N_NA %>%
  filter(n > 1)

modified_nnna <-
  non_unique_issues_N_N_NA %>%
  left_join(HerbCombo %>% select(occurrenceID,
                                 institutionCode,
                                 catalogNumber,
                                 year,
                                 month,
                                 day,
                                 recordedBy,
                                 taxonID,
                                 modified),
            by = c("occurrenceID",
                   "institutionCode",
                   "catalogNumber",
                   "year",
                   "month",
                   "day",
                   "recordedBy",
                   "taxonID"))  %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID,
           modified) %>%
  count()

modified_nnna_Y <-
  modified_nnna %>%
  filter(n == 1)

modified_nnna_N <-
  modified_nnna %>%
  filter(n > 1)  

modified_nnna_Y_latest <-
  modified_nnna_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  slice_max(order_by = modified,
            n = 1)
  
####Task: work on n na stuff####

unique_issues_N_NA_NA <-
  issues_N_NA_NA %>%
  filter(n == 1)

non_unique_issues_N_NA_NA <-
  issues_N_NA_NA %>%
  filter(n > 1)

modified_nnana <-
  non_unique_issues_N_NA_NA %>%
  left_join(HerbCombo %>% select(occurrenceID,
                                 institutionCode,
                                 catalogNumber,
                                 year,
                                 month,
                                 day,
                                 recordedBy,
                                 taxonID,
                                 modified),
            by = c("occurrenceID",
                   "institutionCode",
                   "catalogNumber",
                   "year",
                   "month",
                   "day",
                   "recordedBy",
                   "taxonID"))  %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID,
           modified) %>%
  count()

modified_nnana_Y <-
  modified_nnana %>%
  filter(n == 1)

modified_nnana_N <-
  modified_nnana %>%
  filter(n > 1)  

modified_nnana_Y_latest <-
  modified_nnana_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  slice_max(order_by = modified,
            n = 1)

####Task: work on na na n####

unique_issues_NA_NA_NA <-
  issues_NA_NA_NA %>%
  filter(n == 1)

non_unique_issues_NA_NA_NA <-
  issues_NA_NA_NA %>%
  filter(n > 1)

modified_nanana <-
  non_unique_issues_NA_NA_NA %>%
  left_join(HerbCombo %>% select(occurrenceID,
                                 institutionCode,
                                 catalogNumber,
                                 year,
                                 month,
                                 day,
                                 recordedBy,
                                 taxonID,
                                 modified),
            by = c("occurrenceID",
                   "institutionCode",
                   "catalogNumber",
                   "year",
                   "month",
                   "day",
                   "recordedBy",
                   "taxonID"))  %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID,
           modified) %>%
  count()

modified_nanana_Y <-
  modified_nanana %>%
  filter(n == 1)

modified_nanana_N <-
  modified_nanana %>%
  filter(n > 1)  

modified_nanana_Y_latest <-
  modified_nanana_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  slice_max(order_by = modified,
            n = 1)

####Task: work on na na n####

unique_issues_NA_NA_N <-
  issues_NA_NA_N %>%
  filter(n == 1)

non_unique_issues_NA_NA_N <-
  issues_NA_NA_N %>%
  filter(n > 1)

modified_nanan <-
  non_unique_issues_NA_NA_N %>%
  left_join(HerbCombo %>% select(occurrenceID,
                                 institutionCode,
                                 catalogNumber,
                                 year,
                                 month,
                                 day,
                                 recordedBy,
                                 taxonID,
                                 modified),
            by = c("occurrenceID",
                   "institutionCode",
                   "catalogNumber",
                   "year",
                   "month",
                   "day",
                   "recordedBy",
                   "taxonID"))  %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID,
           modified) %>%
  count()

modified_nanan_Y <-
  modified_nanan %>%
  filter(n == 1)

modified_nanan_N <-
  modified_nanan %>%
  filter(n > 1)  

modified_nanan_Y_latest <-
  modified_nanan_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  slice_max(order_by = modified,
            n = 1)

####tak: w0rk oan na n####

unique_issues_NA_N_N <-
  issues_NA_N_N %>%
  filter(n == 1)

non_unique_issues_NA_N_N <-
  issues_NA_N_N %>%
  filter(n > 1)

modified_nann <-
  non_unique_issues_NA_N_N %>%
  left_join(HerbCombo %>% select(occurrenceID,
                                 institutionCode,
                                 catalogNumber,
                                 year,
                                 month,
                                 day,
                                 recordedBy,
                                 taxonID,
                                 modified),
            by = c("occurrenceID",
                   "institutionCode",
                   "catalogNumber",
                   "year",
                   "month",
                   "day",
                   "recordedBy",
                   "taxonID"))  %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID,
           modified) %>%
  count()

modified_nann_Y <-
  modified_nann %>%
  filter(n == 1)

modified_nann_N <-
  modified_nann %>%
  filter(n > 1)  

modified_nann_Y_latest <-
  modified_nann_Y %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           day,
           recordedBy,
           taxonID) %>%
  slice_max(order_by = modified,
            n = 1)











