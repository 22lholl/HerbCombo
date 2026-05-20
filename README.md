This project puts code from GEOG491 and ENSC381 projects in one place in prep for publication. Directory structure is as follows:

OLD - has original folders of each individual project

SCRIPTS - has scripts written for current project
  +Startup - loads any packages used throughout other scripts, loads any dataframes saved throughout other scripts
  +Workbench - where current coding tasks are worked on. When complete, moved to Archive. If new packages are used or dataframes are saved, information is added to Startup
  +Archive - complete record of scripts written to load, wrangle, analyze, etc. data for project, separated by tasks

DATA - has data
  +CLEAN - has data with various stages/forms of wrangling
  +RAW - copy of RAW_OG, plus any additional raw data needed in course of project (e.g., township information from shapefile)
  +RAW_OG - has original downloads of WisFlora data in DarwinCore and Symbiota formats. Intended to be copy only.

PLOTS - has saved plots from scripts
