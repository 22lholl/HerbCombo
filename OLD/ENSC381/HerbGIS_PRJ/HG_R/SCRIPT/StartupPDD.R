#Lillian Holl
#GEOG 491
#HerbGIS - Startup (Packages, Directory, Data)
#9/24/2025

#set directory
setwd("C:/Users/22lho/OneDrive/HerbGIS_PRJ/HG_R")

#load packages
library(tidyverse)

####RAW DATA####

#SUWS WisFlora, unaltered
SUWS <- read.csv("RAW/occurrence_data_20250922105936_DarwinCore.csv")

#PLSS table from GIS shapefile
PLSS <- 
  read.csv("RAW/PLSS_Townships_1983HARN_TableToExcel.xlsx - PLSS_Townships_1983HARN.csv")

####CLEAN DATA####

#SUWS WisFlora, extraneous columns removed
SUWS_clean <- read.csv("CLEAN/SUWS_clean.csv")

#Coll_pst_sep_col - has catalogNumber, county collected in, as well as primary, secondary, and tertiary collector's names in separate columns
Coll_pst_sep_col <- read.csv("CLEAN/Coll_pst_sep_col.csv")

#Coll_cty_CN - has catalogNumber, county collected in, and name of collector. Specimens may be repeated if there were two or more collectors listed
Coll_cty_CN <- read.csv("CLEAN/Coll_cty_CN.csv")

#TR - has TR and catalogNumber of all specimens that have useable verbatimCoordinate info
TR <- read.csv("CLEAN/TR_CN.csv")

#DUP_CN - has the specimens that are duplicated in the database
DUP_CN_tbl<- read.csv("CLEAN/DUP_CN_tbl.csv")

#OC_tnshps - has Only_Coords Specimens that have tonwship info in same format as TR
OC_tnshps <- read.csv("CLEAN/OC_tnshps.csv")

#CN_coll_cty_tnshp - has catalogNumber associated with collector, county, tnshp
CN_coll_cty_tnshp <- read.csv("CLEAN/CN_coll_cty_tnshp.csv")

###ARCPRO DATA####

#Spec_per_cty.csv - has counties and associated number of specimens collected in it
Spec_per_cty <- read.csv("CLEAN/Spec_per_cty.csv")

#Coll_per_cty.csv - has counties and associated number of collectors that collected at least once in it
Coll_per_cty <- read.csv("CLEAN/Coll_per_cty.csv")

#Only_Coords_Specimens - has catalogNumber and verbatimCoordinates of specimens where their location is only indentified by coordinates
Only_Coords <- read.csv("CLEAN/Only_Coords_Specimens.csv")

#Spec_per_tnshp - has TN and number of spec per township, for ease of mapping
Spec_per_tnshp <- read.csv("CLEAN/Spec_per_tnshp.csv")

#Coll_per_tnshp - has TN and number of coll per township, for ease of mapping
Coll_per_tnshp <- read.csv("CLEAN/Coll_per_tnshp.csv")

#Tnshp_Coll_Spec - has OBJECTID (assigned by ArcPro to each township), number of collectors and number of specimens collected in it
Tnshp_Coll_Spec <- read.csv("CLEAN/Tnshp_Coll_Spec_AP.csv")

#Cty_coll_dist - has county, collector(s) with the highest number of collections, and the number of collections they made
Cty_coll_dist <- read.csv("CLEAN/Cty_coll_dist.csv")

#Tnshp_coll_dist - has township, collector(s) with the highest number of collections, and the number of collections they made
Tnshp_coll_dist <- read.csv("CLEAN/Tnshp_coll_dist.csv")

#Cty_coll_dist_Brashier
Cty_coll_dist_Brashier <- read.csv("CLEAN/Cty_coll_dist_Brashier.csv")

#Tnshp_coll_dist_Brashier
Tnshp_coll_dist_Brashier <- read.csv("CLEAN/Tnshp_coll_dist_Brashier.csv")

#Cty_coll_dist_JWT
Cty_coll_dist_JWT <- read.csv("CLEAN/Cty_coll_dist_JWT.csv")

#Tnshp_coll_dist_JWT
Tnshp_coll_dist_JWT <- read.csv("CLEAN/Tnshp_coll_dist_JWT.csv")

#Cty_coll_dist_DSA
Cty_coll_dist_DSA <- read.csv("CLEAN/Cty_coll_dist_DSA.csv")

#Tnshp_coll_dist_DSA
Tnshp_coll_dist_DSA <- read.csv("CLEAN/Tnshp_coll_dist_DSA.csv")

#Cty_coll_dist_RGK
Cty_coll_dist_RGK <- read.csv("CLEAN/Cty_coll_dist_RGK.csv")

#Tnshp_coll_dist_RGK
Tnshp_coll_dist_RGK <- read.csv("CLEAN/Tnshp_coll_dist_RGK.csv")

#Cty_coll_dist_RC
Cty_coll_dist_RC <- read.csv("CLEAN/Cty_coll_dist_RC.csv")

#Tnshp_coll_dist_RC
Tnshp_coll_dist_RC <- read.csv("CLEAN/Tnshp_coll_dist_RC.csv")

#Cty_coll_dist_Romans
Cty_coll_dist_Romans <- read.csv("CLEAN/Cty_coll_dist_Romans.csv")

#Tnshp_coll_dist_Romans
Tnshp_coll_dist_Romans <- read.csv("CLEAN/Tnshp_coll_dist_Romans.csv")

#Cty_coll_dist_DWD
Cty_coll_dist_DWD <- read.csv("CLEAN/Cty_coll_dist_DWD.csv")

#Tnshp_coll_dist_DWD
Tnshp_coll_dist_DWD <- read.csv("CLEAN/Tnshp_coll_dist_DWD.csv")
