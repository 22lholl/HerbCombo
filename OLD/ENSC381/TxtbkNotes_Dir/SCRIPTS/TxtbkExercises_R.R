#Lillian Holl
#ENSC 381
#R Textbook exercises
#2/8/2026

####Exercise 1 - Getting to know R and RStudio####

#Create a variable called first_num and assign it the value 42. Click on the ‘Environment’ tab in the top right window to display the variable and value. Now create another variable called first_char and assign it a value "my first character". Notice this variable is now also displayed in the ‘Environment’ along with it’s value and class (chr - short for character class).

first_num <- 42

first_char <- "my first character"

# Remove the variable first_num from your environment using the rm() function. Use the code rm(first_num) to do this. Check out the ‘Environment’ tab to ensure the variable has been removed. Alternatively, use the ls() function to list all objects in your environment.

rm(first_num)

ls()

# Let’s see what happens if we assign another value to an existing variable. Assign the value "my second character" to the variable first_char you created in Q6. Notice the value has changed in the ‘Environment’. To display the value of first.char enter the name of the variable in the console. Don’t to forget to save your R script periodically!

first_char <- "my second character"   
  
# OK, back to RStudio. Sometimes you may forget the exact name of a function you want to use so it would be useful to be able to search through all the function names. For example, you want to create a design plot but can only remember that the name of the function has the word ‘plot’ in it. Use the apropos() function to list all the functions with the word plot in their name (see Section 2.5.1 of the Introduction to R book). Look through the list and once you have figured what the correct function is then bring up the help file for this function (Hint: the function name probably has the words ‘plot’ and ‘design’ in it!).

apropos(plot)

# Another strategy would be to use the help.search() function to search through R’s help files. Search the R help system for instances of the character string ‘plot’. Take a look at Section 2.5.1 for more information. Also, see if you can figure out how to narrow your search by only searching for ‘plot’ in the nlme package (hint: see the help page for help.search()).

help.search('plot')

?help.search

help.search("plot",
            package = 'nlme')

# R’s working directory is the default location of any files you read into R, or export from R. Although you won’t be importing or exporting files just yet (that’s tomorrows job) it’s useful to be able to determine what your current working directory is. So, read Section 1.7 of the Introduction to R book to introduce yourself to working directories and figure out how to display your current working directory.

getwd()

# Let’s finish up by creating some additional useful directories in your Project directory. If you’ve followed the Data  instructions when downloading datasets for this course you will already have a directory called data in your Project (if you didn’t then take a look at the instructions under Data  to create this directory). Now let’s create another directory called output where you’ll save data files and plots you generate later on during this course. This time, instead of clicking on the ‘New Folder’ icon in RStudio we’ll create a new directory using R code directly in the R console (you can also interact with your computer’s operating system in all sorts of useful ways). To do this use the dir.create() function to create a directory called output (See Section 1.8 of the Introduction to R book for more details). If you fancy it, you can also create a subdirectory in your output directory called figures to store all your fancy R plots for your thesis. You can list all the files in your directories using the list.files() function. Can you figure out how to list the directories as well? (hint: see ?listfiles or Section 1.8 of the course book).

dir.create("output")

dir.create("output/figures")

list.files()

####Exercise 2 - Basic R operations####

# Let’s use R as a fancy calculator. Find the natural log, log to the base 10, log to the base 2, square root and the natural antilog of 12.43. See Section 2.1 of the Introduction to R book for more information on mathematical functions in R. Don’t forget to write your code in RStudio’s script editor and source the code into the console.

log(12.43)

log10(12.43)

log2(12.43)

sqrt(12.43)

# Next, use R to determine the area of a circle with a diameter of 20 cm and assign the result to an object called area_circle. If you can’t remember how to create and assign objects see Section 2.2 or watch this video. Google is your friend if you can’t remember the formula to calculate the area of a circle! Also, remember that R already knows about pi. Don’t worry if you’re stumped and feel free to ask one of the instructors for guidance.

diameter <- 20

radius <- diameter/2

area_circle <- pi * (radius^2)

# Now for something a little more tricky. Calculate the cube root of 14 x 0.51. You might need to think creatively for a solution (hint: think exponents), and remember that R follows the usual order of mathematical operators so you might need to use brackets in your code (see this page if you’ve never heard of this). The point of this question is not to torture you with maths (so please don’t stress!), its to get you used to writing mathematical equations in R and highlight the order of operations.

(14 * 0.51)^(1/3)

#use the concatenate function c() to create a vector called weight containing the weight (in kg) of 10 children: 69, 62, 57, 59, 59, 64, 56, 66, 67, 66 (Section 2.3 or watch this video for more information).

weight <- c(69,
            62,
            57,
            59,
            59,
            64,
            56,
            66,
            67,
            66)

#Get R to calculate the mean, variance, standard deviation, range of weights and the number of children of your weight vector (see Section 2.3 for more details).

mean(weight)

var(weight)

sd(weight)

range(weight)

# extract the weights for the first five children using Positional indexes and store these weights in a new variable called first_five. Remember, you will need to use the square brackets [ ] to extract (aka index, subset) elements from a variable.

first_five <- weight[1:5]

# We’re now going to use the the c() function again to create another vector called height containing the height (in cm) of the same 10 children: 112, 102, 83, 84, 99, 90, 77, 112, 133, 112. 

height <- c(112,
            102,
            83,
            84,
            99,
            90,
            77,
            112,
            133,
            112)

#Use the summary() function to summarise these data in the height object. 

summary(height)

# Extract the height of the 2nd, 3rd, 9th and 10th child and assign these heights to a variable called some_child (take a look at the section Positional indexes in the R book if you’re stuck). 

some_child <- height[c(2,
                       3,
                       9,
                       10)]

# We can also extract elements using Logical indexes. Let’s extract all the heights of children less than or equal to 99 cm and assign to a variable called shorter_child.

shorter_child <- height[height <= 99]

# Now you can use the information in your weight and height variables to calculate the body mass index (BMI) for each child. The BMI is calculated as weight (in kg) divided by the square of the height (in meters). Store the results of this calculation in a variable called bmi. Note: you don’t need to do this calculation for each child individually, you can use both vectors in the BMI equation – this is called vectorisation (see Section 2.4.4 of the Introduction to R book).

bmi <- weight / ((height/100)^2)

#use the seq() function to create a sequence of numbers ranging from 0 to 1 in steps of 0.1 (this is also a vector by the way) and assign this sequence to a variable called seq1.

seq1 <- seq(0,
           1,
           0.1)

# Next, see if you can figure out how to create a sequence from 10 to 1 in steps of 0.5. Assign this sequence to a variable called seq2 (Hint: you may find it useful to include the rev() function in your code).

seq2 <- rev(seq(1,
                10,
                0.5))

# Let’s go sequence crazy! Generate the following sequences. You will need to experiment with the arguments to the rep() function to generate these sequences (see Section 2.3 for some clues):

#   1 2 3 1 2 3 1 2 3

seq <- c(1,
         2,
         3)
  
seq <- rep(seq,
           times = 3)

seq

# “a” “a” “a” “c” “c” “c” “e” “e” “e” “g” “g” “g”

seq <- c("a",
         "c",
         "e",
         "g")

seq_f <- rep(seq,
             each = 3)

seq_f

# “a” “c” “e” “g” “a” “c” “e” “g” “a” “c” “e” “g”

seq_f <- rep(seq,
             times = 3)

seq_f

# 1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3

seq <- c(1,
         2,
         3)

seq <- rep(seq,
           each = 3,
           times = 2)

seq

# 1 1 1 1 1 2 2 2 2 3 3 3 4 4 5

seq <- c(1,
         2,
         3,
         4,
         5)

seq_one <- rep(seq[1],
               5)

seq_two <- rep(seq[2],
               4)

seq_three <- rep(seq[3],
                 3)

seq_four <- rep(seq[4],
                2)

seq_num <- c(seq_one,
             seq_two,
             seq_three,
             seq_four,
             seq[5])

seq_num

# 7 7 7 7 2 2 2 8 1 1 1 1 1

seq <- c(7,
         2,
         8,
         1)

seq_7 <- rep(seq[1],
               4)

seq_2 <- rep(seq[2],
               3)

seq_1 <- rep(seq[4],
                 5)

seq_num <- c(seq_7,
             seq_2,
             seq[3],
             seq_1)

seq_num

# Ok, back to the variable height you created in Q7. Let’s sort the values of height into ascending order (shortest to tallest) and assign the sorted vector to a new variable called height_sorted. Take a look at Section 2.4.3 in the R book to see how to do this. Now sort all heights into descending order and assign the new vector a name of your choice.

height_sorted <- sort(height)

height_sorted_desc <- rev(sort(height))

# Let’s give the children some names. Create a new vector called child_name with the following names of the 10 children: "Alfred", "Barbara", "James", "Jane", "John", "Judy", "Louise", "Mary", "Ronald", "William".

child_name <- c("Alfred",
                "Barbara",
                "Jane",
                "John",
                "Judy",
                "Louise",
                "Mary",
                "Ronald",
                "William")

# A really useful (and common) task is to order the values of one variable by the order of another variable. To do this you will need to use the order() function in combination with the square bracket notation [ ]. Have a peep at Section 2.4.3 for some details. Create a new variable called names_sort to store the names of the children ordered by child height (from shortest to tallest). Who is the shortest? who is the tallest child? If you’re not sure how to do this, please ask one of the instructors.

names_sort <- child_name[order(height)]

#shortest
names_sort[1]

#tallest
names_sort[10]

# Now order the names of the children by descending values of weight and assign the result to a variable called weight_rev (Hint: perhaps include the rev() function?). Who is the heaviest? Who is the lightest?

weight_rev <- child_name[rev(order(weight))]

#heaviest
weight_rev[1]

#lightest
weight_rev[10]

#create a vector called mydata with the values 2, 4, 1, 6, 8, 5, NA, 4, 7. Notice the value of the 7th element of mydata is missing. Now use the mean() function to calculate the mean of the values in mydata. What does R return? Confused? Next, take a look at the help page for the function mean(). Can you figure out how to alter your use of the mean() function to calculate the mean without this missing value?

mydata <- c(2,
            4,
            1,
            6,
            8,
            5,
            NA,
            4,
            7)

mean(mydata,
     na.rm = TRUE)

#   Finally, list all variables in your workspace that you have created in this exercise. Remove the variable seq1 from the workspace using the rm() function.

ls()

rm(seq1)

####Exercise 3 - Importing and Manipulating Data frames####

#Time for a quick description of the ‘whaledata.txt’ dataset to get your bearings. These data were collected during two research cruises in the North Atlantic in May and October 2003. During these two months the research vessel visited multiple stations (areas) and marine mammal observers recorded the number of whales (who doesn’t love whales!) at each of these stations. The time the vessel spent at each station was also recorded along with other site specific variables such as the latitude and longitude, water depth and gradient of the seabed. The researchers also recorded the ambient level of sub-surface noise with a hydrophone and categorised this variable into ‘low’, ‘medium’ or ‘high’. The structure of these data is known as a rectangular dataset (aka ‘tidy’ data by the cool kids) with no missing cells. Each row is an individual observation and each column a separate variable. The variable names are contained in the first row of the dataset (aka a header).

# 5. Now let’s import the ‘whaledata.txt’ file into R. To do this you will use the workhorse function of data importing, read.table(). assign it a variable with an appropriate name (such as whale).

whale <- read.table(file = "data/whaledata.csv",
                    header = TRUE,
                    sep = ",")

# 6. A much, much better option is to use the str() function to display the structure of the dataset and a neat summary of your variables. Another advantage is that you can copy this information from the console and paste it into your R script (making sure it’s commented) for later reference. How many observations does this dataset have? How many variables are in this dataset? What type of variables are month and water.noise?

str(whale)

#whale has 100 observations of 8 variables.
#month is a character variable type.
#water.noise is also a character variable type.
 
#   7. You can get another useful summary of your dataframe by using the summary() function. This will provide you with some useful summary statistics for each variable. Notice how the type of output depends on whether the variable is a factor or a number. Another useful feature of the summary() function is that it will also count the number of missing values in each variable. Which variables have missing values and how many?

summary(whale)

#number of whales has 1 missing value

#   8. Summarising and manipulating dataframes is a key skill to acquire when learning R. 

# Extract all the elements of the first 10 rows and the first 4 columns of the whale dataframe and assign to a new variable called whale.sub.

whale.sub <- whale[1:10,
                   1:4]

# Next, extract all observations (remember - rows) from the whale dataframe and the columns month, water.noise and number.whales and assign to a variable called whale.num.

whale.num <- whale[,
                   c("month",
                     "water.noise",
                     "number.whales")]

# Now, extract the first 50 rows and all columns form the original dataframe and assign to a variable whale.may (there’s a better way to do this with conditional statements - see below).

whale.may <- whale[1:50,]

# Finally, extract all rows except the first 10 rows and all columns except the last column. Remember, for some of these questions you can specify the columns you want either by position or by name. Practice both ways. Do you have a preference? If so why?

whale.last <- whale[-1:-10,
                    1:7]

whale.last <- whale[-1:-10,
                    -which(names(whale) == "gradient")]

#prefer removing by name - that way if order of columns changes, code can adapt
#note:solution to removing column by name is not covered in textbook

#   9. Extract rows from your dataframe (all columns by default) based on the following criteria (note: you will need to assign the results of these statements to appropriately named variables, I’ll leave it up to you to use informative names!):

#   at depths greater than 1200 m

depth_greater_1200m <- whale[whale$depth > 1200, ]

# gradient steeper than 200 degrees

gradient_steeper_200deg <- whale[whale$gradient > 200, ]

# water noise level of ‘low’

water.noise_low <- whale[whale$water.noise == "low", ]

# water.noise level of ‘high’ in the month of ‘May’

water.noise_high_May <- whale[whale$water.noise == "low" &
                                whale$month == "May", ]

# month of ‘October’, water noise level of ‘low’ and gradient greater than the median value of gradient (132)

water.noise_low_October_gradient_abv_mean <- whale[whale$water.noise == "low" &
                                                     whale$month == "October" &
                                                     whale$gradient > 132, ]

# all observations from between latitudes 60.0 and 61.0 and longitudes -6.0 and -4.0

lat_60to61_long_neg6toneg4 <- whale[whale$latitude >= 60 &
                                      whale$latitude <= 61 &
                                      whale$longitude >= -6.0 &
                                      whale$longitude <= -4.0, ]

# all rows that do not have a water noise level of medium

water.noise_NOT_med <- whale[whale$water.noise != "medium", ]

# 10. A really neat feature of extracting rows based on conditional statements is that you can include R functions within the statement itself. To practice this, modify your answer to the gradient question in Q9e to use the median() function rather than hard coding the value 132.

water.noise_low_October_gradient_abv_mean <- whale[whale$water.noise == "low" &
                                                     whale$month == "October" &
                                                     whale$gradient > median(whale$gradient), ]

# 11. However, when using functions in conditional statements you need to be careful. For example, write some code to extract all rows from the dataframe whale with depths greater than 1500 m and with a greater number of whales spotted than average (hint: use the mean() function in your conditional statement). Can you see a problem with the output? Discuss the cause of this problem with an instructor and explore possible solutions.

depths_greater_1500m_abv_avg_whales <- whale[whale$depth > 1500 &
                                               whale$number.whales > mean(whale$number.whales), ]

#output has NAs because one of the observations of the number of whales is NA

depths_greater_1500m_abv_avg_whales <- whale[whale$depth > 1500 &
                                               whale$number.whales > mean(whale$number.whales,
                                                                          na.rm = TRUE), ]
 
# 12. Use the subset() function to extract all rows in ’May’ with a time at station less than 1000 minutes and a depth greater than 1000 m. Also use subset() to extract data collected in ‘October’ from latitudes greater than 61 degrees but only include the columns month, latitude, longitude and number.whales.

May_1000min_less_1000m_greater <- subset(whale,
                                         month == "May" &
                                           time.at.station < 1000 &
                                           depth > 1000)

October_lat_61up <- subset(whale,
                           month == "October" &
                             latitude > 61,
                           select = c("month",
                                      "latitude",
                                      "longitude",
                                      "number.whales"))

# 13. Use the order() function to sort all rows in the whale dataframe in ascending order of depth (shallowest to deepest). Store this sorted dataframe in a variable called whale.depth.sort.

whale.depth.sort <- whale[order(whale$depth), ]

# 14. Sort all rows in the whale dataframe by ascending order of depth within each level of water noise. The trick here is to remember that you can order by more than one variable when using the order() function (see Section 3.4.3 again). Don’t forget to assign your sorted dataframe to a new variable with a sensible name. Repeat the previous ordering but this time order by descending order of depth within each level of water noise.

whale.depth.sort.noise <- whale[order(whale$water.noise,
                                      whale$depth), ]

whale.depth.sort.noise <- whale[order(whale$water.noise,
                                      whale$depth,
                                      decreasing = TRUE), ]

# 15. write some R code to calculate the mean number of whales sighted at each of the three levels of water noise (see Section 3.5 for a few hints). Next, calculate the median number of whales sighted at each level of water noise and for each month.

tapply(whale$number.whales,
       whale$water.noise,
       median,
       na.rm = TRUE)

tapply(whale$number.whales, 
       list(whale$month,
            whale$water.noise),
       median,
       na.rm = TRUE)

# 16. Use the aggregate() function to calculate the mean of time at station, number of whales, depth and gradient for each level of water noise (don’t forget about that sneaky NA value). Next calculate the mean of time at station, number of whales, depth and gradient for each level of water noise for each month. (Optional): For an extra bonus point see if you can figure out how to modify your previous code to display the mean values to 2 decimal places rather than the default of 3 decimal places.

aggregate(time.at.station ~
            water.noise,
          FUN = mean,
          data = whale)

aggregate(number.whales ~
            water.noise,
          FUN = mean,
          data = whale)

aggregate(depth ~
            water.noise,
          FUN = mean,
          data = whale)

aggregate(gradient ~
            water.noise,
          FUN = mean,
          data = whale)

#by month

aggregate(time.at.station ~
            water.noise + month,
          FUN = mean,
          data = whale)

aggregate(number.whales ~
            water.noise + month,
          FUN = mean,
          data = whale)

aggregate(depth ~
            water.noise + month,
          FUN = mean,
          data = whale)

aggregate(gradient ~
            water.noise + month,
          FUN = mean,
          data = whale)

#only two decimal places

aggregate(time.at.station ~
            water.noise,
          FUN = function(x) { round(mean(x), digits = 2) },
          data = whale)

# 17. Use the table() function to determine the number of observations for each level of water noise (see Section 3.5 for a few tips). Next use the same function to display the number of observations for each combination of water noise and month. (Optional): The xtabs() function is very flexible for creating tables of counts for factor combinations (aka contingency tables). Take a look at the help file (or Google) to figure out how to use the xtabs() function to replicate your use of the table() function.

table(whale$water.noise)

table(whale$water.noise,
      whale$month)

xtabs(~ water.noise + month,
      data = whale)

# 18. Let’s say you want to export the dataframe whale.num you created previously (see Q8) to a file called ‘whale_num.txt’ in your output directory which you created in Exercise 1. To do this you will need to use the write.table() function. You want to include the the variable names in the first row of the file, but you don’t want to include the row names. Also, make sure the file is a tab delimited file. Once you have create your file, try to open it in Microsoft Excel (or open source equivalent).

write.table(whale,
            file = "data/whale_num.txt",
            row.names = FALSE,
            col.names = TRUE,
            sep = "/t")

####Exercise 4 - Visualizaing data using base R and lattice graphics####

# 4. Import the ‘squid1.txt’ file into R using the read.table() function and assign it to a variable named squid. 

squid <- read.table('data/squid1.txt',
                    header = TRUE)

#Use the str() function to display the structure of the dataset and the summary() function to summarise the dataset. 

str(squid)

summary(squid)

#How many observations are in this dataset? 519
#How many variables? 13

#The year, month and maturity.stage variables were coded as integers in the original dataset. Here we would like to code them as factors. Create a new variable for each of these variables in the squid dataframe and recode them as factors. 

squid$year <- as.factor(squid$year)
squid$month <- as.factor(squid$month)
squid$maturity.stage <- as.factor(squid$maturity.stage)

#Use the str() function again to check the coding of these new variables.

str(squid)

# 5. How many observations are there per month and year combination (hint: remember the table() or xtabs() functions?)? Don’t forget to use the factor recoded versions of these variables. 

table(squid$year,
      squid$month)

table(squid$year)

#Do you have data for each month in each year? no 
#Which years have the most observations? 1990

#Use a combination of the xtabs() and ftable() functions to create a flattened table of the number of observations for each year, maturity stage and month (aka a contingency table).

ftable(xtabs( ~ year + maturity.stage + month,
              data = squid))

# 6. Create dotplots (using the dotchart() function) for the following variables; DML, weight, nid.length and ovary.weight. Do these variables contain any unusually large or small observations? Don’t forget, if you prefer to create a single figure with all 4 plots you can always split your plotting device into 2 rows and 2 columns (see Section 4.4 of the book). Use the pdf() function to save a pdf version of your plot(s) in your output directory you created in Exercise 1 (see Section 4.5 of the book to see how the pdf() function works).

pdf(file = 'output/exercise4_5.pdf')

par(mfrow = c(2,2))

dotchart(squid$DML)

dotchart(squid$weight)

dotchart(squid$nid.length)

dotchart(squid$ovary.weight)

dev.off()

# 7. We can clearly see this value is over 400 so we can use the which() function to identify which observation this is which(squid$nid.length > 400). It looks like this is the 11th observation of the squid$nid.length variable. Use your skill with the square brackets [ ] to first confirm the this is the correct value (you should get 430.2) and then change this value to 43.2. 

which(squid$nid.length > 400)

squid$nid.length[11]

squid$nid.length[11] <- 43.2

squid$nid.length[11]

#Now redo the dotchart to visualise your correction.

pdf(file = 'output/exercise4_5.pdf')

par(mfrow = c(2,2))

dotchart(squid$DML)

dotchart(squid$weight)

dotchart(squid$nid.length)

dotchart(squid$ovary.weight)

dev.off()

# 8. When exploring your data it is often useful to visualise the distribution of continuous variables. Take a look at Section 4.2.2 and then create histograms for the variables; DML, weight, eviscerate.weight and ovary.weight. Again, its up to you if you want to plot all 4 plots separately or in the same figure. Export your plot(s) as pdf file(s) to the output directory. 

pdf(file = 'output/exercise4_8.pdf')

par(mfrow = c(2,2))

hist(squid$DML)

hist(squid$weight)

hist(squid$nid.length)

hist(squid$ovary.weight)

dev.off()

#One potential problem with histograms is that the distribution of data can look quite different depending on the number of ‘breaks’ used. The hist() function does it’s best to create appropriate ‘breaks’ for your plots (it uses the Sturges algorithm for those that want to know) but experiment with changing the number of breaks for the DML variable to see how the shape of the distribution changes (see Section 4.2.2 of the book for further details of how to change the breaks).

pdf(file = 'output/exercise4_8_2.pdf')

par(mfrow = c(2,2))

hist(squid$DML,
     breaks = 5)

hist(squid$DML,
     breaks = 10)

hist(squid$DML)

hist(squid$DML,
     breaks = 20)

dev.off()

# 9. Plot the relationship between DML on the x axis and weight on the y axis. 

plot(x = squid$DML,
     y = squid$weight)

#How would you describe this relationship? Is it linear? curve upwards

#One approach to linearising relationships is to apply a transformation on one or both variables. Try transforming the weight variable with either a natural log (log()) or square root (sqrt()) transformation. I suggest you create new variables in the squid dataframe for your transformed variables and use these variables when creating your new plots (ask if you’re not sure how to do this). 

squid$log_DML <- log(squid$DML)
squid$log_weight <- log(squid$weight)

plot(x = squid$log_DML,
     y = squid$log_weight)

squid$sqrt_DML <- sqrt(squid$DML)
squid$sqrt_weight <- sqrt(squid$weight)

plot(x = squid$sqrt_DML,
     y = squid$sqrt_weight)

#Which transformation best linearises this relationship? log

# 10. Create a boxplot to visualise the differences in DML at each maturity stage (don’t forget to use the recoded version of this variable you created in Q4) . Include x and y axes labels in your plot. 

boxplot(DML ~ maturity.stage,
        data = squid,
        xlab = "Maturity Stage",
        ylab = "Dorsal Mantle Length")

#An alternative to the boxplot is the violin plot. A violin plot is a combination of a boxplot and a kernel density plot and is great at visualising the distribution of a variable. To create a violin plot you will first need to install the vioplot package from CRAN and make it available using library(vioplot). You can now use the vioplot() function in pretty much the same way as you created your boxplot (again Section 4.2.3 of the book walks you through this).

library(vioplot)

vioplot(DML ~ maturity.stage,
        data = squid,
        xlab = "Maturity Stage",
        ylab = "Dorsal Mantle Length")

# 11. Use the coplot() function (Section 4.2.6) to plot the relationship between DML on the x axis and square root transformed weight on the y axis (you created this variable in Q8) for each level of maturity stage. 

coplot(sqrt_weight ~ DML|maturity.stage,
       data = squid)

#Does the relationship between DML and weight look different for each maturity stage (suggesting an interaction)? sharp break around 150 betweens tages 1 and 2, relationship overall looks linear?

#If you prefer, you can also create a similar plot using the xyplot() function (Section 4.2.7) from the lattice package (don’t forget to make the function available by using library(lattice) first).

library(lattice)

xyplot(sqrt_weight ~ DML|maturity.stage,
       data = squid)

# 12. Create a pairs plot for the variables; DML, weight, eviscerate.weight, ovary.weight, nid.length, and nid.weight (see Section 4.2.5 of the book for more details). 

pairs(squid[ ,
             c("DML",
               "weight",
               "eviscerate.weight",
               "ovary.weight",
               "nid.length",
               "nid.weight")])

#Modify your pairs plot to include a histogram of the variables on the diagonal panel and include a correlation coefficient for each relationship on the upper triangle panels. Also include a smoother (wiggly line) in the lower triangle panels to help visualise these relationships.

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

panel.hist <- function(x, ...)
{
  usr <- par("usr")
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

pairs(squid[ ,
             c("DML",
               "weight",
               "eviscerate.weight",
               "ovary.weight",
               "nid.length",
               "nid.weight")],
      panel = panel.smooth,
      upper.panel = panel.cor,
      diag.panel = panel.hist)

# 13. Use the plot() function to produce a scatterplot of DML on the x axis and ovary weight on the y axis (you might need to apply a transformation on the variable ovary.weight). 

squid$sqrt_ovary.weight <- sqrt(squid$ovary.weight)

plot(sqrt_ovary.weight ~ DML,
     data = squid)

#Use a different colour to highlight points for each level of maturity stage. 

plot(sqrt_ovary.weight ~ DML,
     data = squid,
     type = "n",
     xlab = "Dorsal Mantle Length",
     ylab = "Square Root of Ovary Weight")

points(x = squid$DML[squid$maturity.stage == "1"],
       y = squid$sqrt_ovary.weight[squid$maturity.stage == "1"],
       pch = 3,
       col = "red")

points(x = squid$DML[squid$maturity.stage == "2"],
       y = squid$sqrt_ovary.weight[squid$maturity.stage == "2"],
       pch = 3,
       col = "orange")

points(x = squid$DML[squid$maturity.stage == "3"],
       y = squid$sqrt_ovary.weight[squid$maturity.stage == "3"],
       pch = 3,
       col = "yellow")

points(x = squid$DML[squid$maturity.stage == "4"],
       y = squid$sqrt_ovary.weight[squid$maturity.stage == "4"],
       pch = 3,
       col = "green")

points(x = squid$DML[squid$maturity.stage == "5"],
       y = squid$sqrt_ovary.weight[squid$maturity.stage == "5"],
       pch = 3,
       col = "blue")

#Produce a legend explaining the different colours and place it in a suitable position on the plot. 

leg_cols <- c("red",
              "orange",
              "yellow",
              "green",
              "blue")

leg_sym <- c(3,
             3,
             3,
             3,
             3)

leg_lab <- c("1",
             "2",
             "3",
             "4",
             "5")

legend(x = 60,
       y = 8,
       col = leg_cols,
       pch = leg_sym,
       legend = leg_lab,
       bty = "n",
       title = "Maturity Stage")

####Exercise 5 - Basic statistics in R####

# 1. Download the datafile ‘prawnGR.CSV’ from the  Data link and save it to the data directory. Import these data into R and assign to a variable with an appropriate name. 

prawn <- read.csv('data/prawnGR.csv')

#Have a quick look at the structure of this dataset and plot the growth rate versus the diet using an appropriate plot. 

str(prawn)
summary(prawn)

boxplot(GRate ~ diet,
        data = prawn)

#change diet to factor?

prawn$diet <- as.factor(prawn$diet)

str(prawn)

#How many observations are there in each diet treatment? 30

table(prawn$diet)

#   2. You want to compare the difference in growth rate between the two diets using a two sample t-test. Before you conduct the test, you need to assess the normality and equal variance assumptions. 

#Use the function shapiro.test() to assess normality of growth rate for each diet separately (Hint: use your indexing skills to extract the growth rate for each diet GRate[diet=='Natural'] first). 

prawn_nat <- prawn$GRate[prawn$diet=='Natural']

shapiro.test(prawn_nat)

prawn_art <- prawn$GRate[prawn$diet=='Artificial']

shapiro.test(prawn_art)

#Use the function var.test() to test for equal variance (see ?var.test for more information or Section 6.1 of the book for more details). 

var.test(prawn_nat,
         prawn_art)

#Are your data normally distributed and have equal variances? is normally distributed because p-value greater than 0.05, has equal variances because p-value is greater than 0.05

# 3. Conduct a two sample t-test using the t.test() function (Section 6.1 of the book). Use the argument var.equal = TRUE to perform the t-test assuming equal variances. 

t.test(prawn$GRate ~ prawn$diet,
       var.equal = TRUE)

#What is the null hypothesis you want to test? there is a difference between the means of the artificial and natural diets

#Do you reject or fail to reject the null hypothesis? fail to reject null because p-value is greater than 0.05

#What is the value of the t statistic, degrees of freedom and p value? -1.3259, 58, 0.1901

# 4. Use the lm() function to fit a linear model with GRate as the response variable and diet as an explanatory variable (see Section 6.3 for a very brief introduction to linear modelling). Assign (<-) the results of the linear model to a variable with an appropriate name (i.e. growth.lm).

growth.lm <- lm(GRate ~ diet,
                data = prawn)

# 5. Produce an ANOVA table for the fitted model using the anova() function i.e. anova(growth.lm). Compare the ANOVA p value to the p value obtained using a t-test. What do you notice? What is the value of the F statistics and degrees of freedom? How would you summarise these results in a report?

anova(growth.lm)

#anova p-value - 0.1901
#t.test p-value - 0.1901

#df is also the same
  
#   6. Assess the normality and equal variance assumptions by plotting the residuals of the fitted model (see Section 6.3 for more details). Split the plotting device into 2 rows and 2 columns using par(mfrow=c(2,2)) so you can fit four plots on a single device. Use the plot() function on your fitted model (plot(growth.lm)) to plot the graphs. What are your conclusions?

par(mfrow = c(2,2))

plot(growth.lm)

#   7. Download the datafile ‘Gigartina.CSV’ from the  Data link and save it to the data directory. Import the dataset into R and assign the dataframe an appropriate name. 

gigartina <- read.csv('data/Gigartina.csv')

#Use the function str() to examine the dataframe. How many replicates are there per diatom treatment? Use an appropriate plot to examine whether there are any obvious differences in diameter between the treatments.

str(gigartina)

table(gigartina$diatom.treat)

boxplot(diameter ~ diatom.treat,
        data = gigartina)

# 8. You wish to compare the mean diameter of Metacarpus grown in the four treatment groups (ASGM, Sdecl, Sexpo, Sstat) using a one-way analysis of variance (ANOVA). What is your null hypothesis? that there is no difference between the four treatment groups
 
#   9. We will conduct the ANOVA using the linear model function lm() once again. Fit the linear model and assign the model output to a variable with an appropriate name (i.e. gigartina.lm).

gigartina.lm <- lm(diameter ~ diatom.treat,
                   data = gigartina)

# 10. Produce an ANOVA table using the anova() function. What is the value of the p value? Do you reject or fail to reject the null hypothesis? What is the value of the F statistic and degrees of freedom? How would you report these summary statistics in a report?

anova(gigartina.lm)

#reject null - groups are significantly different
  
#   11. Assess the assumptions of normality and equal variance of the residuals by producing the residual plots as before. Don’t forget to split the plotting device into 2 rows and 2 columns before plotting. Do you accept this model as acceptable?

par(mfrow = c(2,2))

plot(gigartina.lm)
  
#13. We will use the function TukeyHSD() from the mosaic package to perform these comparisons (you will need to install this package first and then use library(mosaic) to make the function available). Which groups are different from each other if we use the p-value cutoff (alpha) of p < 0.05?

library(mosaic)

TukeyHSD(aov(gigartina.lm))

#   14. We can also produce a plot of the comparisons to help us interpret the table of comparisons. Use the plot() function with the TukeyHSD(gigartina.lm). Ask if you get stuck (or Google it!).

plot(TukeyHSD(aov(gigartina.lm)))

# 15. Download the ‘TemoraBR.csv’ file from the  Data link and save it to the data directory. Import the dataset into R and as usual assign it to a variable. 

temora <- read.csv('data/TemoraBR.csv')

#How many variables are there? What type of variables are they? Which is the response (dependent) variable, and which are the explanatory (independent) variables?

str(temora)

#temps are independent variables, beat rate is dependent variable

temora$acclimitisation_temp <- as.factor(temora$acclimitisation_temp)
 
#   16. What type of variable is acclimitisation_temp? Is it a factor? Convert acclimitisation_temp to a factor and store the result in a new column in your dataframe called Facclimitisation_temp. Hint: use the function factor(). Use an appropriate plot to visualise these data (perhaps a coplot or similar?).

temora$acclimitisation_temp <- as.factor(temora$acclimitisation_temp)

coplot(beat_rate ~ temp|acclimitisation_temp,
       data = temora)

# 17. We will analyse these data using an Analysis of Covariance (ANCOVA) to compare the slopes and the intercepts of the relationship between beat_rate and temp for each level of Facclimatisation_temp. Take a look at the plot you produced in Q16, do you think the relationships are different? think slope is gonna be diff esp for 20
  
#   18. As usual we will fit the model using the lm() function. You will need to fit the main effects of temp and Facclimatisation_temp and the interaction between temp and Facclimatisation_temp. 

temora.lm <- lm(beat_rate ~ temp * acclimitisation_temp,
                data = temora)

# 19. Produce the summary ANOVA table as usual. Is the interaction between temp and Facclimatisation_temp significant? What is the interpretation of the interaction term? Should we interpret the main effects of temp and Facclimatisation_temp as well?

anova(temora.lm)

#   20. Assess the assumptions of normality and equal variance of the residuals in the usual way. Do the residuals meet these assumptions?

par(mfrow = c(2,2))

plot(temora.lm)

# 21. Write a short summary in you R script (don’t forget to comment this out with #) describing the interpretation of this model. Report the appropriate summary statistics such as F values, degrees of freedom and p values.


                         
#22. (Optional) refit the model using the square root transformed beat_rate as the response variable. Does the interpretation of the model change? Do the validation plots of the residuals look better?