#Lillian Holl
#ENSC 381
#R Textbook examples
#1/24/2026

####CH 1 - Getting started with R and RStudio####
  ####1.1.4 - testing R####

plot(1:10)

  ####1.5.1 - CRAN packages####

install.packages('remotes',
                 dependencies = TRUE)

update.packages(ask = FALSE)
#using ask = FALSE avoids asking on every package - esp useful w/ CRAN for me cause I have alot of packages

  ####1.5.2 - Bioconductor packages####

install.packages('BiocManager',
                 dependencies = TRUE)

#installing all core Bioconductor packages, also used to update bioconductor packages
#using ask = FALSE avoids asking on every package

BiocManager::install()

#installing specific Bioconductor packages

BiocManager::install(c("GenomicRanges",
                       "edgeR"))

  ####1.5.3 - Github packages####

#this is not code I actually want to run because it installs the dev version of tidyverse, not the stable CRAN version

#before using install_github function (from remotes package), need to know GitHub username and name of repository
#best practice to update packages from github with following command as well

#remotes::install_github('tidyverse/dplyr')

  ####1.5.4 - using packages####

#use library to access - have to do it every session, otherwise will get error that R couldn't find function

library(remotes)

#don't want to load whole package? can call package and function

#remotes::install_github('tidyverse/dplyr')

  ####1.7 - Working directories####

#setwd() is common, but uses absolute path (not really transferable between different devices...)

#can use root directories with relative paths
#copy over entire project directory, then just use references to relevant file paths

# so like a setwd() to C:\Users\22lho\OneDrive\Desktop\ENSC 381\TxtbkNotes_Dir, but then using things like /FILES after

  ####1.8 - Directory Structure####

#creating directories w/ script - can also do it with file explorer, but fun to try new way
#also easier to mvoe scripts/data around with 

dir.create('SCRIPTS')

  ####1.10 - project documentation####

#timestamps - haven't seen this one before

#write ts, then press shift + tab

# Sat Jan 24 13:18:23 2026

#commenting out multiple lines

# highlight lines, then ctrl + shift + c

# comment
# out
# multiple
# lines

  ####1.13 - citing R####

#citation for R

citation()

#citation for particular packages

#oops didn't install package here
install.packages('here')
library(here)

citation(package = "here")
 




####CH 2 - Some R basics ####
  ####2.1 - Getting started####

#wxplooring arithmetic operators
#using r like a calculator

2 + 2

log(1)

log10(1)

exp(1)

sqrt(4)

4^2

pi

####2.2.1 - creating objects

# assignment operator is <-

my_obj <- 48

my_obj

#put text in quotes
my_obj2 <- "R is cool"

#can switch type by changing value
my_obj2 <- 1024

#adding object together (make sure of same type, lol)
my_obj3 <- my_obj + my_obj2

my_obj3

#common error code: object not found
#issue is that no_obj has not been defined

my_obj4 <- my_obj + no_obj

  ####2.2.2 - Naming Objects####

#multiple words in name

#snake case (underscore, is preferred by authors)
output_summary <- "my analysis"

#snake case not only way
output.summary <- "my analysis"

outputSummary <- "my analysis"

#other guidelines
  #do not start with dot or number
  #avoid non-alphanumeric characters (ex. &)
  #don't name w/ reserved word (ex. TRUE)
  #don't name w/ same name as function (ex. data)

  ####2.3 - Using functions in R####

#the c() function
  #concatenate
  #use to join together a series of values and store them in a data structure called a vector

my_vec <- c(2,
            3,
            1,
            6,
            4,
            3,
            3,
            7)

my_vec

#mean
mean(my_vec)

#variance
var(my_vec)

#standard deviation
sd(my_vec)

#length (aka number of elements in vector)
length(my_vec)

#assign value to be used later in analysis
vec_mean <- mean(my_vec)

vec_mean

#creating a sequence

#using the colon : symbol
my_seq <- 1:10

my_seq

my_seq2 <- 10:1

my_seq2

#using seq()
  #nice cause get control over by how much using arguments - other methods doing by whole number
my_seq2 <- seq(from = 1,
               to = 5,
               by = 0.5)

my_seq2

#using rep()

my_seq3 <- rep(2,
               times = 10)

my_seq3

#repeating non-numeric values

my_seq4 <- rep("abc",
               times = 3)

my_seq4

#repeating each element of a series

my_seq5 <- rep(1:5,
               times = 3)

my_seq5

#repeating elements of a series
  #difference is that change argument

my_seq6 <- rep(1:5,
               each = 3)

my_seq6

#repeat non-sequqential
  #get to nest functions!

my_seq7 <- rep(c(3,
                 1,
                 10,
                 7),
               each = 3)

my_seq7

  ####2.4.1 - Extracting elements####

#use [] to extract from a vector

#positional index
  #starts at 1 for R

my_vec

#get third value from my_vec
my_vec[3]

#store third value from my_vec in obj
val_3 <- my_vec[3]

val_3

#extract more than one value

#particular positions
my_vec[c(1,
         5,
         6,
         8)]

#particular range

my_vec[3:8]

#logical index

#extracting all values greater than 4
my_vec[my_vec > 4]

#only elements that were true were extracted
my_vec > 4

my_vec[c(FALSE,
         FALSE,
         FALSE,
         TRUE,
         FALSE,
         FALSE,
         FALSE,
         TRUE)]

#other operators, including composite operators

#greater than or equal to - >=
my_vec[my_vec >= 4]

#less than - <
my_vec[my_vec < 4]

#less than or equal to - <=
my_vec[my_vec <= 4]

#equal to - ==
my_vec[my_vec == 4]

#not equal to - !=
my_vec[my_vec != 4]

#Boolean expressions (combining multiple logical expressions)
  #& - AND
  #| # OR

#extract values less than 6 AND greater than 2
val26 <- my_vec[my_vec < 6 &
                  my_vec > 2]

val26

#extract values greater than 6 OR less than 3

val63 <- my_vec[my_vec > 6 |
                  my_vec < 3]

val63

  ####2.4.2 - Replacing elements####

#replace value at a specific position
my_vec[4] <- 500

my_vec

#replace one value based on logic
my_vec[c(6,
         7)] <- 100

my_vec

#replace elements based on logic
my_vec[my_vec <= 4] <- 1000

my_vec

  ####2.4.3 - Ordering elements####

#sort from low to high - sort()
vec_sort <- sort(my_vec)

vec_sort

#sort from high to low - two methods

#set decreasing argument to TRUE
vec_sort2 <- sort(my_vec,
                  decreasing = TRUE)

vec_sort2

#sort w/ sort() then reverse with rev()
vec_sort3 <- rev(sort(my_vec))

vec_sort3

#sort one vector according to values of another vector
  #order() in combo w/ []

height <- c(180, 
            155, 
            160, 
            167, 
            181)

height

p.names <- c("Joanna", 
             "Charlotte", 
             "Helen", 
             "Karen", 
             "Amy")

p.names

#order people in p.names in ascending order of their height

#step 1: use order() w/ height variable to create vector called height_ord

height_ord <- order(height)

height_ord
  #gives position of each in order

#step 2:extract values from p.names using heights in ascending order

names_ord <- p.names[height_ord]

names_ord

  ####2.4.4 - Vectorisation####

#functions will operate on all elements of a vector without needing to apply the function on each element separately

#multiply each element by 5
my_vec2 <- c(3,
             5,
             7,
             1,
             9,
             20)

my_vec2 * 5

#adding the elements of two or more vectors
my_vec3 <- c(17,
             15,
             13,
             19,
             11,
             0)

my_vec2 + my_vec3

#multiply both vectors
my_vec2 * my_vec3

#caution - R will recycle elements in shorter vector rather than throw error

my_vec4 <- c(1,2)

my_vec2

my_vec2 + my_vec4

  ####2.4.5 - Missing data####

#thermometer broke on day 2 and on day 9
temp  <- c(7.2, 
           NA, 
           7.1, 
           6.9, 
           6.5, 
           5.8, 
           5.8, 
           5.5, 
           NA, 
           5.5)

temp

#ignore na values when calculating mean to avoid error code

mean_temp <- mean(temp,
                  na.rm = TRUE)

mean_temp

  ####2.5 - Getting help####

help("mean")

?mean

#if don't know complete name

help.search("mean")

??mean

#list all functions w/ specified character string

apropos("mean")

#search in function pages/vignettes

RSiteSearch("regression")

  ####2.6 - Saving stuff in R####

#saving an object
  #save(nameOfObject, file = "name_of_file.RData)

#save all object into single file
  #save.image(file = "name_of_file.RData)

#load data back into RStudio
  #load(file = "name_of_file.RData)

####CH 3 - Data in R####
  ####3.1 - Data types####

#find type/class of objects using class()

num <- 2.2
class(num)

char <- "hello"
class(char)

logi <- TRUE
class(logi)

#testing if object is a specific class

is.numeric(num)

is.character(num)

is.character(char)

is.logical(logi)

#changing class of variable

num_char <- as.character(num)
num_char

class(num_char)

char_num <- as.numeric(char)

  ####3.2.2 - Matrices and arrays####

#creating a matrix

my_mat <- matrix(1:16,
                 nrow = 4,
                 byrow = TRUE)

my_mat

#creating an array

my_array <- array(1:16,
                  dim = c(2,
                          4,
                          2))

my_array

#defining row and column names for a matrix

rownames(my_mat) <- c("A",
                      "B",
                      "C",
                      "D")

colnames(my_mat) <- c("a",
                      "b",
                      "c",
                      "d")

my_mat

#transpose a matrix

my_mat_t <- t(my_mat)

my_mat_t

#extracting diagonal elements of a matrix

my_mat_diag <- diag(my_mat)

my_mat_diag

#matrix operations

mat.1 <- matrix(c(2, 0, 1, 1), nrow = 2)

mat.1

mat.2 <- matrix(c(1, 1, 0, 2), nrow = 2)

mat.2

mat.1 + mat.2

mat.1 * mat.2

mat.1 %*% mat.2

  ####3.2.3 - Lists####

list_1 <- list(c("black", "yellow", "orange"),
               c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE),
               matrix(1:6,
                      nrow = 3))

list_1

#naming elements of list during creation of it

list_2 <- list(colors = c("black", "yellow", "orange"),
               evaluation = c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE),
               time = matrix(1:6,
                      nrow = 3))

list_2

#naming elements afer list has been created

names(list_1) <- c("colors",
                   "evaluation",
                   "time")

list_1

  ####3.2.4 - Data Frames####

#creating a data frame from vectors

p.height <- c(180,
              155,
              160,
              167,
              181)

p.weight <- c(65,
              50,
              52,
              58,
              70)

p.names <- c("Joanna",
             "Charlotte",
             "Helen",
             "Karen",
             "Amy")

dataf <- data.frame(height = p.height,
                    weight = p.weight,
                    names = p.names)

dataf

#get dimensions of data frame

dim(dataf)

#get summary of data frame structure

str(dataf)

  ####3.3.2 - Import Functions####

#import file and assign to object
#note: textbook does tab sep, but I did comma sep because that is what I am familiar with/could get google sheets to export. only thing that changes in theory is it is blackslash then t in double quotes instead of ,

flowers <- read.table(file = 'data/flower.csv',
                      header = TRUE,
                      sep = ",",
                      stringsAsFactors = TRUE)

#check whether data imported correctly

str(flowers)

#don't want strings as factors? there's a fix for that when importing

flowers <- read.table(file = 'data/flower.csv',
                      header = TRUE,
                      sep = ",",
                      stringsAsFactors = FALSE)

str(flowers)

#names of variables(columns)

names(flowers)

  ####3.4 - Wrangling data frames####

#access a aparticular column in a data frame

flowers$height

#assign to vector, calc mean, get a summary

f_height <- flowers$height

mean(f_height)

summary(f_height)

#doing calcs on the fly (display only in console)

mean(flowers$height)

summary(flowers$height)

  ####3.4.1 - Positional Indexes####

#access data in frames
#notation: my_data[rows, columns]

flowers[1,4]

flowers$height[1]

#extract values from multiple rows/columns

flowers[1:10,
        1:4]

#extracting values from non-sequential rows/columns

flowers[c(1,
          5,
          12,
          30),
        c(1,
          3,
          6,
          8)]

#extracting either all rows or all columns - leave blank before/after comma

flowers[1:8, ]

flowers[ , 1:3]

#use negative positional indexes to exclude

flowers[-(1:85),
        -c(4, 7, 8)]

#name variables directly when extracting

flowers[1:5,
        c("treat",
          "nitrogen",
          "leafarea")]

  ####3.4.2 - Logical Indexes####

#export data from data frame base on logical test

big_flowers <- flowers[flowers$height >12, ]

#extract rows based on value of string or factor level

nit_high <- flowers[flowers$nitrogen == "high", ]

nit_high

nit_not_medium <- flowers[flowers$nitrogen != "medium",
                          1:4]

nit_not_medium

#increase complexity by combining with boolean expressions

low_notip_heigh6 <- flowers[flowers$height >= 6 & 
                              flowers$nitrogen == "medium" & 
                              flowers$treat == "notip", ]

low_notip_heigh6

height2.2_12.3 <- flowers[flowers$height > 12.3 |
                            flowers$height < 2.2, ]

height2.2_12.3

#alternative method - subset

tip_med_2 <- subset(flowers,
                    treat == "tip" & 
                      nitrogen == "medium" &
                      block == 2)

tip_med_2

tipplants <- subset(flowers,
                    treat == "tip" & 
                      nitrogen == "medium" &
                      block == 2,
                    select = c("treat",
                               "nitrogen",
                               "leafarea"))

tipplants

  ####3.4.3 - ordering data frames####

#order in ascending value

height_ord <- flowers[order(flowers$height), ]
height_ord

#order in descending value

leafarea_ord <- flowers[order(flowers$leafarea,
                              decreasing = TRUE), ]
leafarea_ord


#order based on multiple variables

block_height_ord <- flowers[order(flowers$block,
                                  flowers$height), ]
block_height_ord

#order ascending in one column than descending in another column
#note: minus only works with numeric variables

block_revheight_ord <- flowers[order(flowers$block,
                                     -flowers$height), ]
block_revheight_ord

#order by factor/character alphabetically

block_revheight_ord <- flowers[order(-xtfrm(flowers$nitrogen),
                                            flowers$height), ]
block_revheight_ord

#order by factor/character specified
#note: order factor then can be used in order function

flowers$nitrogen <- factor(flowers$nitrogen,
                           levels = c("low",
                                      "medium",
                                      "high"))

nit_ord <- flowers[order(flowers$nitrogen), ]

nit_ord

  ####3.4.4 - Adding columns and rows####

#creating data frames

df1 <- data.frame(id = 1:4,
                  height = c(120,
                             150,
                             132,
                             122),
                  weight = c(44,
                             56,
                             49,
                             45))

df1

df2 <- data.frame(id = 5:6,
                  height = c(119,
                             110),
                  weight = c(35,
                             35))

df2

df3 <- data.frame(id = 1:4,
                  height = c(120,
                             150,
                             132,
                             122),
                  weight = c(44,
                             56,
                             49,
                             45))

df3

df4 <- data.frame(location = c("UK",
                               "CZ",
                               "CZ",
                               "UK"))

#add rows

df_rcomb <- rbind(df1,
                  df2)

df_rcomb

#add columns

df_ccomb <- cbind(df3,
                  df4)

df_ccomb

#add new column/performing transformation on variable

df_rcomb$height_log10 <- log10(df_rcomb$height)

df_rcomb

#converting existing variable to another type

df_rcomb$Fid <- factor(df_rcomb$id)

df_rcomb

str(df_rcomb)

  ####3.4.5 - Merging data frames####

taxa <- data.frame(GENUS = c("Patella", "Littorina", "Halichondria", "Semibalanus"),
                   species = c("vulgata", "littoria", "panacea", "balanoides"),
                   family = c("patellidae", "Littorinidae", "Halichondriidae", "Archaeobalanidae"))

taxa

zone <- data.frame(genus = c("Laminaria", "Halichondria", "Xanthoria", "Littorina", 
                             "Semibalanus", "Fucus"),
                   species = c("digitata", "panacea", "parietina", "littoria", 
                               "balanoides", "serratus"),
                   zone = c( "v_low", "low", "v_high", "low_mid", "high", "low_mid"))

zone

#merging data frames

taxa_zone <- merge(x = taxa,
                   y = zone)

taxa_zone

#including all NAs

taxa_zone <- merge(x = taxa,
                   y = zone,
                   all = TRUE)

taxa_zone

#basing merge on different variable names

taxa_zone <- merge(x = taxa,
                   y = zone,
                   all = TRUE,
                   by.x = "GENUS",
                   by.y = "genus")

taxa_zone

#basing merge on multiple variable names

taxa_zone <- merge(x = taxa,
                   y = zone,
                   all = TRUE,
                   by.x = c("species",
                            "GENUS"),
                   by.y = c("species",
                            "genus"))

taxa_zone

  ####3.4.6 - Reshaping data frames####

#long is where each row is a single observation from an individual subject and each subject can ahve multiple rows

long_data <- data.frame(subject = rep(c("A", "B", "C", "D"), each = 3),
                        sex = rep(c("M", "F", "F", "M"), each =3),
                        condition = rep(c("control", "cond1", "cond2"), times = 4),
                        measurement = c(12.9, 14.2, 8.7, 5.2, 12.6, 10.1, 8.9,
                                        12.1, 14.2, 10.5, 12.9, 11.9))
long_data

#wide is where have multiple observations from each subect in a single row, where measurements are in different columns

wide_data <- data.frame(subject = c("A", "B", "C", "D"),
                        sex = c("M", "F", "F", "M"),
                        control = c(12.9, 5.2, 8.9, 10.5),
                        cond1 = c(14.2, 12.6, 12.1, 12.9),
                        cond2 = c(8.7, 10.1, 14.2, 11.9))
wide_data

#install reshape2 for converting between formats

install.packages("reshape2")

library(reshape2)

#wide to long

my_long_df <- melt(data = wide_data,
                   id.vars = c("subject",
                               "sex"),
                   measured.vars = c("control",
                                     "cond1",
                                     "cond2"),
                   variable.name = "condition",
                   value.name = "measurement")

my_long_df

#long to wide

my_wide_df <- dcast(data = long_data, 
                    subject + sex ~ condition, 
                    value.var = "measurement")
my_wide_df

  ####3.5 - Summarising data frames####

summary(flowers)

#summarize a subset

summary(flowers [, 4:7])

#summarize a single variable

summary(flowers$leafarea)

#generate tables of counts (alt to summary)

table(flowers$nitrogen)

table(flowers$nitrogen,
      flowers$treat)

#another way to generate tables

xtabs(~ nitrogen + treat,
      data = flowers)

xtabs(~ nitrogen + treat + block,
      data = flowers)

#flattening table

ftable(xtabs(~ nitrogen + treat + block,
             data = flowers))

#summarize data for each level of a factor

tapply(flowers$height,
       flowers$nitrogen,
       mean)

tapply(flowers$height, 
       flowers$nitrogen,
       sd)

tapply(flowers$height, 
       flowers$nitrogen,
       summary)

#specificying removing NAs

tapply(flowers$height,
       flowers$nitrogen,
       mean,
       na.rm = TRUE)

#apply functions to more than one factor

tapply(flowers$height,
       list(flowers$nitrogen,
            flowers$treat),
       mean)

#not having to write name of object every time

with(flowers,
     tapply(height,
       list(nitrogen,
            treat),
       mean))

#another way to summarize - alternate way to tapply()

aggregate(flowers[, 4:7],
          by = list(nitrogen = flowers$nitrogen),
          FUN = mean)

#including more than one factor

aggregate(flowers[, 4:7],
          by = list(nitrogen = flowers$nitrogen,
                    treat = flowers$treat),
          FUN = mean)

#formula method

aggregate(height ~ nitrogen + treat,
          FUN = mean,
          data = flowers)

#can use subsets with formula method

aggregate(height ~ nitrogen + treat,
          FUN = mean,
          subset = flowers < 7,
          data = flowers)

aggregate(height ~ nitrogen + treat,
          FUN = mean,
          subset = block == "1",
          data = flowers)

  ####3.6 - Exporting Data####

flowers_df2 <- flowers[order(flowers$nitrogen, flowers$height), ]
flowers_df2$flowers_sqrt <- sqrt(flowers_df2$flowers)
flowers_df2$log10_height <- log10(flowers_df2$height)
str(flowers_df2)

write.table(flowers_df2,
            file = 'data/flowers_04_12.txt',
            col.names = TRUE,
            row.names = FALSE,
            sep = "/t")

write.table(flowers_df2,
            file = 'data/flowers_04_12.txt',
            col.names = TRUE,
            row.names = FALSE,
            sep = ",")

write.csv(flowers_df2,
          file = 'data/flowers_04_12.txt',
          row.names = FALSE)

####CH 4 - Graphics with base R####

#call lattice

library(lattice)

  ####4.2.1 - Scatterplots####

#load in flowers data

flowers <- read.table(file = 'data/flower.csv',
                      header = TRUE,
                      sep = ",",
                      stringsAsFactors = TRUE)

plot(flowers$weight)

#using with() to not use $ - shortcut

with(flowers,
     plot(weight))

#x and y arguments

plot(x = flowers$weight,
     y = flowers$shootarea)

#formula notation for plot()

plot(flowers$shootarea ~ flowers$weight)

#specify type of scatterplot

my_x <- 1:10
my_y <- seq(from = 1,
            to = 20,
            by = 2)

par(mfrow = c(2,2))

plot(my_x,
     my_y,
     type = "l")

plot(my_x,
     my_y,
     type = "b")

plot(my_x,
     my_y,
     type = "o")

plot(my_x,
     my_y,
     type = "c")

  ####4.2.2 - Histograms####

hist(flowers$height)

#retitle, set breaks

brk <- seq(from = 0,
           to = 18,
           by = 1)

hist(flowers$height,
     breaks = brk,
     main = "petunia height")

#display as proportion

hist(flowers$height,
     breaks = brk,
     main = "petunia height",
     freq = FALSE)

#adding a kernel density curve to plot

dens <- density(flowers$height)

hist(flowers$height,
     breaks = brk,
     main = "petunia height",
     freq = FALSE)

lines(dens)

  ####4.2.3 - Box and violin plots####

boxplot(flowers$weight,
        ylab = "weight (g)")

#see how distribution of variable changes between different levels of a factor

boxplot(weight ~ nitrogen,
        data = flowers,
        ylab = "weight (g)",
        xlab = "nitrogen level")

#change the order of factors

flowers$nitrogen <- factor(flowers$nitrogen,
                           levels = c("low",
                                      "medium",
                                      "high"))

boxplot(weight ~ nitrogen,
        data = flowers,
        ylab = "weight (g)",
        xlab = "nitrogen level")

#two factors in the same plot

boxplot(weight ~ nitrogen * treat,
        data = flowers,
        ylab = "weight (g)",
        xlab = "nitrogen level")

#reduce text size to fit labels

boxplot(weight ~ nitrogen * treat,
        data = flowers,
        ylab = "weight (g)",
        xlab = "nitrogen level",
        cex.axis = 0.7)

#install and run vioplot package

#install.packages('vioplot')

library(vioplot)

vioplot(weight ~ nitrogen,
        data = flowers,
        ylab = "weight (g)",
        xlab = "nitrogen level",
        col = "lightblue")

  ####4.2.4 - Dot charts####

#dotcharts help identify outliers. x is particular variable, y is the order in which appear in dataframe

dotchart(flowers$height)

#group values by factor

dotchart(flowers$height,
         groups = flowers$nitrogen)

  ####4.2.5 - Pairs plots####

#graph all combination of variables

pairs(flowers[ ,
              c("height",
                "weight",
                "leafarea",
                "shootarea",
                "flowers")])

#add LOWESS

pairs(flowers[ ,
               c("height",
                 "weight",
                 "leafarea",
                 "shootarea",
                 "flowers")],
      panel = panel.smooth)

#more useful panel functions

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr")
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

pairs(flowers[ ,
               c("height",
                 "weight",
                 "leafarea",
                 "shootarea",
                 "flowers")],
      lower.panel = panel.cor)

#generate histogram of each variable

panel.hist <- function(x, ...)
{
  usr <- par("usr")
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

pairs(flowers[ ,
               c("height",
                 "weight",
                 "leafarea",
                 "shootarea",
                 "flowers")],
      lower.panel = panel.cor,
      diag.panel = panel.hist,
      upper.panel = panel.smooth)

  ####4.2.6 - Coplots####

coplot(flowers ~ weight|leafarea,
       data = flowers)

#don't want overlapping data in panels

coplot(flowers ~ weight|leafarea,
       data = flowers,
       overlap = 0)

#conditioning variables

coplot(flowers ~ weight|nitrogen,
       data = flowers)

coplot(flowers ~ weight|nitrogen * treat,
       data = flowers)

#apply functions to panels

coplot(flowers ~ weight|nitrogen * treat,
       data = flowers,
       panel = function(x, y, ...) {
         points(x, y, ...)
         abline(lm(y ~ x), col = "blue")
       })

  ####4.2.7 - Lattice Plots####

library(lattice)

#recreate hist() with different package

histogram(~ height,
          type = "count",
          data = flowers)

#recreate boxplots with different package

bwplot(weight ~ nitrogen,
       data = flowers)

#plot graphs in multiple panels

histogram(~ height|nitrogen,
          type = "count",
          data = flowers)

bwplot(weight ~ nitrogen|block,
       data = flowers)

#change layout of plot panels

histogram(~ height|nitrogen,
          type = "count",
          layout = c(1,3),
          data = flowers)

#put block numbers on panel

class(flowers$block)

flowers$FBlock <- factor(flowers$block)

bwplot(weight ~ nitrogen|factor(block),
       data = flowers)

#include multiple conditioning variables

xyplot(height ~ weight | nitrogen * treat,
       data = flowers)

#highlight datapoints by groups

xyplot(height ~ weight | nitrogen * treat,
       groups = block,
       auto.key = TRUE,
       data = flowers)

  ####4.3.1 - Customizing with arguments####

plot(flowers$weight,
     flowers$shootarea)

#adding axis labels

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = "shoot area (cm2)")

#adding superscript

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")))

#adjust plot margins

par(mar = c(4.1,
            4.4,
            4.1,
            1.9))

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")))

#increase range of axes

par(mar = c(4.1,
            4.4,
            4.1,
            1.9))

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200))

#remove box around plot

par(mar = c(4.1,
            4.4,
            4.1,
            1.9))

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l")

#fix origin, rotate tick mark labels, adjust ick labels

par(mar = c(4.1,
            4.4,
            4.1,
            1.9),
    xaxs = "i",
    yaxs = "i")

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l",
     las = 1,
     cex.axis = 0.8,
     tcl = -0.2)

#changing symbols

par(mar = c(4.1,
            4.4,
            4.1,
            1.9),
    xaxs = "i",
    yaxs = "i")

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l",
     las = 1,
     cex.axis = 0.8,
     tcl = -0.2,
     pch = 16,
     col = "dodgerblue1",
     cex = 0.9)

#add text label to plot

par(mar = c(4.1,
            4.4,
            4.1,
            1.9),
    xaxs = "i",
    yaxs = "i")

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l",
     las = 1,
     cex.axis = 0.8,
     tcl = -0.2,
     pch = 16,
     col = "dodgerblue1",
     cex = 0.9)

text(x = 28,
     y = 190,
     label = "A",
     cex = 2)

  ####4.3.2 - Building Plots####

par(mar = c(4.1,
            4.4,
            4.1,
            1.9),
    xaxs = "i",
    yaxs = "i")

plot(flowers$weight,
     flowers$shootarea,
     type = "n",
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l",
     las = 1,
     cex.axis = 0.8,
     tcl = -0.2)

#add points from low level of nitrogen

par(mar = c(4.1,
            4.4,
            4.1,
            1.9),
    xaxs = "i",
    yaxs = "i")

plot(flowers$weight,
     flowers$shootarea,
     type = "n",
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l",
     las = 1,
     cex.axis = 0.8,
     tcl = -0.2)

points(x = flowers$weight[flowers$nitrogen == "low"],
       y = flowers$shootarea[flowers$nitrogen == "low"],
       pch = 16,
       col = "deepskyblue")

#add medium level

points(x = flowers$weight[flowers$nitrogen == "medium"],
       y = flowers$shootarea[flowers$nitrogen == "medium"],
       pch = 16,
       col = "yellowgreen")

#add high level and label

points(x = flowers$weight[flowers$nitrogen == "high"],
       y = flowers$shootarea[flowers$nitrogen == "high"],
       pch = 16,
       col = "deeppink3")

text(x = 28,
     y = 190,
     label = "A",
     cex = 2)

#add legend

leg_cols <- c("deepskyblue",
              "yellowgreen",
              "deeppink3")

leg_sym <- c(16,
             16,
             16)

leg_lab <- c("low",
             "medium",
             "high")

legend(x =1,
       y = 200,
       col = leg_cols,
       pch = leg_sym,
       legend = leg_lab,
       bty = "n",
       title = "Nitrogen level")

  ####4.4 - multiple graphs####

#1 row, 2 columns (side by side)

par(mfrow = c(1,
              2))

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight",
     ylab = "shoot area")

boxplot(shootarea ~ nitrogen,
        data = flowers,
        cex.axis = 0.6)

#2 rows, 2 columns (four plots)

par(mfrow = c(2,
              2))

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight",
     ylab = "shoot area")

boxplot(shootarea ~ nitrogen,
        data = flowers,
        cex.axis = 0.8)

hist(flowers$weight,
     main ="")

dotchart(flowers$weight)

#reset plotting device

par(mfrow = c(1,1))

#set up layout matrix for layout()

layout_mat <- matrix(c(2,
                       0,
                       1,
                       3),
                     nrow = 2,
                     ncol = 2,
                     byrow = TRUE)

layout_mat

#create representation

my_lay <- layout(mat = layout_mat,
                 heights = c(1,
                             3),
                 widths = c(3,
                            1),
                 respect = TRUE)

layout.show(my_lay)

#make 3 paneled plot

par(mar = c(4,
            4,
            0,
            0))

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = "shoot area (cm2)")

par(mar = c(0,
            4,
            0,
            0))

boxplot(flowers$weight,
        horizontal = TRUE,
        frame = FALSE,
        axes = FALSE)

par(mar = c(4,
            0,
            0,
            0))

boxplot(flowers$shootarea,
        frame = FALSE,
        axes = FALSE)

  ####4.5 - Exporting plots####

#save as pdf

pdf(file = 'output/my_plot.pdf')

par(mar = c(4.1,
            4.4,
            4.1,
            1.9),
    xaxis = "i",
    yaxis = "i")

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l",
     las = 1,
     cex.axis = 0.8,
     tcl = -0.2,
     pch = 16,
     col = "dodgerblue1",
     cex = 0.9)

text(x = 28,
     y = 190,
     label = "A",
     cex = 2)

dev.off()

#save as png

png('output/my_plot.png')

par(mar = c(4.1,
            4.4,
            4.1,
            1.9),
    xaxis = "i",
    yaxis = "i")

plot(flowers$weight,
     flowers$shootarea,
     xlab = "weight (g)",
     ylab = expression(paste("shoot area (cm"^"2",")")),
     xlim = c(0, 30),
     ylim = c(0, 200),
     bty = "l",
     las = 1,
     cex.axis = 0.8,
     tcl = -0.2,
     pch = 16,
     col = "dodgerblue1",
     cex = 0.9)

text(x = 28,
     y = 190,
     label = "A",
     cex = 2)

dev.off()

####CH 6 - Simple Statistics in R####
  ####6.1 - One and two sample tests####

data(trees)
str(trees)
summary(trees)

#test whether mean height is equal to 70 feet

t.test(trees$Height,
       mu = 70)

#because of low p-value, reject null - means that mean ehight is not equal to 70

#testing whether greater than 70 feet

t.test(trees$Height,
       mu = 70,
       alternative = "greater")

#use rank based method when there are departures from normality

wilcox.test(trees$Height,
            mu = 70)

#error is supposed to come up - just doesn't like it when lots of values are teh same number

#Assessing normality w/ Q-Q plot

qqnorm(trees$Height)
qqline(trees$Height,
       lty = 2)

#Assessing normality w/ Shaprio-Wilkes

shapiro.test(trees$Height)

#can assume data is normally distributed

#testing for differences between two samples - whether they have different means

atmos <- read.table('data/atmosphere.txt',
                    header = TRUE)
str(atmos)

t.test(atmos$moisture ~ atmos$treatment)

#test above assumes variances are not equal, can specify if variances are equal

t.test(atmos$moisture ~ atmos$treatment,
       var.equal = TRUE)

#test whether variances are equal

var.test(atmos$moisture ~ atmos$treatment)

#wilcox with formula method

wilcox.test(atmos$moisture ~ atmos$treatment)

#testing paired data

pollution <- read.table('data/pollution.txt',
                        header = TRUE)
str(pollution)

#looking to see if means between two measures are different

t.test(pollution$down,
       pollution$up,
       paired = TRUE)

wilcox.test(pollution$down,
            pollution$up,
            paired = TRUE)


#comparing proportions

buy <- c(45,71)

total <- c((45 + 35), (71 + 32))

prop.test(buy, total)

#chi-square

buyers <- matrix(c(45,
                   35,
                   71,
                   32),
                 nrow = 2)

buyers

colnames(buyers) <- c("before",
                      "after")

rownames(buyers) <- c("buy",
                      "not buy")


buyers

chisq.test(buyers)

  ####6.2 - Correlation####

#estimate correlation coefficient

data("trees")
str(trees)

#specific variables

cor(trees$Height,
    trees$Volume)

#coefficients of all variables

cor(trees)

#tell R what to do when an observation is missing

cor(trees,
    use = "complete.obs")

#testing whether correlation significantly different from 0

cor.test(trees$Height,
         trees$Volume)

#different methods - use arguments

cor.test(trees$Height,
         trees$Volume,
         method = "spearman")

  ####6.3 - Simple linear modeling####

#fitting a linear model

smoke <- read.table('data/smoking.txt',
                    header = TRUE,
                    stringsAsFactors = TRUE)

str(smoke)

ggplot(mapping = aes(x = smoking,
                     y = mortality),
       data = smoke) +
  geom_point()

smoke_lm <- lm(mortality ~ smoking,
               data = smoke)

summary(smoke_lm)

anova(smoke_lm)

#factor and continuous variable - lm equivalent to anova

#risk.group is not in included dat - unable to run code even if I did type it out

#adding fitted line to plot

ggplot(mapping = aes(x = smoking,
                     y = mortality),
       data = smoke) +
  geom_point() +
  geom_smooth(method = "lm",
              se = TRUE)

plot(smoke$smoking,
     smoke$mortality,
     xlab = "smoking rate",
     ylab = "mortality rate")

abline(smoke_lm,
       col = "red")

#check assumptions

#equal variances

smoke_res <- resid(smoke_lm)

smoke_fit <- fitted(smoke_lm)

ggplot(mapping = aes(x = smoke_fit,
                     y = smoke_res)) +
  geom_point() +
  geom_hline(yintercept = 0,
             colour = "red",
             linetype = "dashed")

#no wedge or clear pattern - is good

#normality of residuals - Q-Q plot

ggplot(mapping = aes(sample = smoke_res)) +
  stat_qq() +
  stat_qq_line()

#OR

qqnorm(smoke_res)
qqline(smoke_res)

#make all four diagnostic plots

par(mfrow = c(2,2))
plot(smoke_lm)

#OR

autoplot(smoke_lm,
         which = 1:6,
         ncol = 2,
         label.size = 3)

#what happens to parameters when remove data

smoke_lm2 <- update(smoke_lm,
                    subset = -2)

summary(smoke_lm2)

#other functions useful for producing diagnostic plots

par(mfrow = c(2,2))

#dffits - expresses how much an observation influences the associated fitted value

plot(dffits(smoke_lm),
     type = "l")

#rstudent - returns studentised residuals

plot(rstudent(smoke_lm))

#dfbetas - gives change in the estimated parameters if an observation is excluded

matplot(dfbetas(smoke_lm),
        type = "l",
        col = "black")

#cook's distances

lines(sqrt(cooks.distance(smoke_lm)),
      lwd = 2)

####CH 7 - Programming in R####
  ####7.2 - Functions in R####

#creating dataset

city <- data.frame(
  porto = rnorm(100),
  aberdeen = rnorm(100),
  nairobi = c(rep(NA, 10),
              rnorm(90)),
  genoa = rnorm(100))

#make function

multiply_columns <- function(x, y) {
  return(x * y)
}

#use function

porto_aberdeen_func <- multiply_columns(x = city$porto,
                                        y = city$aberdeen)

aberdeen_nairobi_func <- multiply_columns(x = city$aberdeen,
                                        y = city$nairobi)

#add warnings to function

multiply_columns <- function(x, y) {
  temp_var <- x * y
  if(any(is.na(temp_var))) {
    warning("The function has produced NAs")
    return(temp_var)
  } else {
    return(temp_var)
  }
}

  ####7.3 - Conditional Statements####

eggs <- TRUE

n.milk <- ifelse(eggs == TRUE,
                 yes = 6,
                 no = 1)

#make a function to determine how much milk to buy based on eggs

milk <- function(eggs) {
  if (eggs ==TRUE) {
    6
  } else {
    1
  }
}

milk(eggs = TRUE)

  ####7.4 - Combining logical operators####

good.day <- function(code.working, day) {
  if (code.working == TRUE && day == "Friday") {
    "BEST. DAY. EVER. Stop while you are ahead and go to the pub!"
  } else if (code.working == FALSE && day == "Friday") {
    "Oh well, but at least it's Friday! Pub time!"
  } else if (code.working == TRUE && day != "Friday") {
    "So close to a good day... shame it's not a Friday"
  } else if (code.working == FALSE && day != "Friday") {
    "Hello darkness"
  } 
}

#test function

good.day(FALSE,
         "Tuesday")
  ####7.5.1 - For loop####

#for loops used when want to repeat task a defined number of times

for (i in 1:5) {
  print(i)
}

#real example

temp <- list()

for (i in 1:(ncol(city) - 1)) {
  temp[[i]] <- multiply_columns(x = city[ , i],
                                y = city[ , i + 1])
}

  ####7.5.2 - while loop####

i <- 0

while (i <=4) {
  i <- i + 1
  print(i)
}

  ####7.5.4 - If not loops, then what?####

#lapply

lapply(0:4,
       function(a) {a + 1})

####CH 8 - Reproducible reports with R markdown####
  ####8.3  - Get started with R markdown####

#load packages

library(rmarkdown)

library(tinytex)

  ####8.4 - Create an R markdown document####

#use command line rather than clicking

render('markdown/CH_8_Notes.Rmd',
       output_format = 'html_document')
