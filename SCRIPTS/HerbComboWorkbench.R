#Lillian Holl
#HerbCombo - puts GEOG491 and ENSC381 projects in one place in prep for publication
#Workbench
#5/18/2026

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
