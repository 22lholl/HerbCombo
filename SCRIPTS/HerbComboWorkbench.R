#Lillian Holl
#HerbCombo - puts GEOG491 and ENSC381 projects in one place in prep for publication
#Workbench
#5/18/2026

####Task: filter by unique year/month/day/recordedBy/taxonID####

#create third filter (year/month/day/recordedBy/taxonID in this case)

issues_Y_Y_third <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_Y_Y$occurrenceID,
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
#   filter(occurenceID %in% issues_Y_N$occurrenceID &
#            catalogNumber %in% issues_Y_N$catalogNumber) %>%
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

#have to pull institution code and occurence ID with N's because have not yet been uniquely identified - otherwise will pull occurence IDs from other instituions not in list

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
         institutionCode %in% issues_N_N$institutionCode,
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

#NN decisions

issues_N_N_Y <-
  issues_N_N_third %>%
  filter(n == 1,
         !(is.na(year) |
             is.na(month) |
             is.na(day) |
             is.na(recordedBy) |
             is.na(taxonID)))

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

test_issues_N_N_Y <-
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
           recordedBy) %>%
  count()
  

#filtering to see which columns out of year, month, day, recordedBy, and taxonID records are uniquely identified by

issues_N_N_Y_year <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_N_N$occurrenceID,
         institutionCode %in% issues_N_N$institutionCode,
         catalogNumber %in% issues_N_N$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           month,
           day,
           recordedBy,
           taxonID) %>%
  count() %>%
  filter(n > 1)

issues_N_N_Y_month <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_N_N$occurrenceID,
         institutionCode %in% issues_N_N$institutionCode,
         catalogNumber %in% issues_N_N$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           day,
           recordedBy,
           taxonID) %>%
  count() %>%
  filter(n > 1)
  
issues_N_N_Y_day <-
  HerbCombo %>%
  filter(occurrenceID %in% issues_N_N$occurrenceID,
         institutionCode %in% issues_N_N$institutionCode,
         catalogNumber %in% issues_N_N$catalogNumber) %>%
  group_by(occurrenceID,
           institutionCode,
           catalogNumber,
           year,
           month,
           recordedBy,
           taxonID) %>%
  count() %>%
  filter(n > 1)

issues_N_N_Y_recordedBy <-
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
           taxonID) %>%
  count() %>%
  filter(n > 1)

issues_N_N_Y_taxonID <-
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
           recordedBy) %>%
  count() %>%
  filter(n > 1)

#seems to be that major issue is that when identification is upgraded, it duplicates in system rather than deleting old record? (nny taxonID have more records - not grouping by this with higher multiple records means that identification likely changed at some point in curation history. fix with adding identification date (w/o adding taxon ID back in) and accept most recent record as the correct one?

#rest of records from nny is a little bit mysterious why not unique - see if from different sources (test with group by list), maybe do n sum test to see if all records captured?

#FIX THE LARGE FILE ERROR IN DATA/RAW

