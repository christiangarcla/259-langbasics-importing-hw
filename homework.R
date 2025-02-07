#PSYC 259 Homework 1 - Data Import
#For full credit, provide answers for at least 6/8 questions

#List names of students collaborating with (no more than 2): Just Christian

#GENERAL INFO 
#data_A contains 12 files of data. 
#Each file (6192_3.txt) notes the participant (6192) and block number (3)
#The header contains metadata about the session
#The remaining rows contain 4 columns, one for each of 20 trials:
#trial_number, speed_actual, speed_response, correct
#Speed actual was whether the figure on the screen was actually moving faster/slower
#Speed response was what the participant report
#Correct is whether their response matched the actual speed

### QUESTION 1 ------ 

# Load the readr package

library(readr)

### QUESTION 2 ----- 

# Read in the data for 6191_1.txt and store it to a variable called ds1
# Ignore the header information, and just import the 20 trials
# Be sure to look at the format of the file to determine what read_* function to use
# And what arguments might be needed

# ds1 should look like this:

# # A tibble: 20 × 4
#  trial_num    speed_actual speed_response correct
#   <dbl>       <chr>        <chr>          <lgl>  
#     1          fas          slower         FALSE  
#     2          fas          faster         TRUE   
#     3          fas          faster         TRUE   
#     4          fas          slower         FALSE  
#     5          fas          faster         TRUE   
#     6          slo          slower         TRUE
# etc..

# A list of column names are provided to use:

col_names  <-  c("trial_num","speed_actual","speed_response","correct")

# ANSWER

fname <- "data_A/6191_1.txt"
col_names  <-  c("trial_num","speed_actual","speed_response","correct")
ds1 <- read_delim(file = fname, col_names = col_names, skip = 7)
print(ds1)

#MComment: This looks right, but the HW key recommends using read_tsv (the commands in the function are the same)
#Key: ds1 <- read_tsv("data_A/6191_1.txt", skip = 7, col_names = col_names)

### QUESTION 3 ----- 

# For some reason, the trial numbers for this experiment should start at 100
# Create a new column in ds1 that takes trial_num and adds 100
# Then write the new data to a CSV file in the "data_cleaned" folder

# ANSWER
# Create a calculated column
ds1$trial_num_100 <- (ds1$trial_num+100)
# See the results
print(ds1)
# Let's write the combined data to disk
write_csv(ds1, file = "data_A/ds1_combined.csv") #This isn't combined yet, just the 1 data file

#MComment: Note the HW also instructs making a new folder called data_cleaned
          #Putting the cleaned and uncleaned in the same folder is confusing (and messes up Q4 technically)

### QUESTION 4 ----- 

# Use list.files() to get a list of the full file names of everything in "data_A"
# Store it to a variable

# ANSWER
# Get list of files
full_file_names <- list.files("data_A", full.names = TRUE)
print(full_file_names)

### QUESTION 5 ----- 

# Read all of the files in data_A into a single tibble called ds

# ANSWER
#hmmmmm I think i'm missing something
# Pass the list to read_csv to read all of them into a single tibble
ds <- read_csv(full_file_names)
print(ds)

#MComment: Right idea, but you'd wanna use read_tsv (because it's a txt.file, not csv)
            #Also, you'd wanna use the same code as Q2 (i.e. skip 7 rows and rename columns)

#Key: ds <- read_tsv(fnames, skip = 7, col_names = col_names)

### QUESTION 6 -----

# Try creating the "add 100" to the trial number variable again
# There's an error! Take a look at 6191_5.txt to see why.
# Use the col_types argument to force trial number to be an integer "i"
# You might need to check ?read_tsv to see what options to use for the columns
# trial_num should be integer, speed_actual and speed_response should be character, and correct should be logical
# After fixing it, create the column to add 100 to the trial numbers 
# (It should work now, but you'll see a warning because of the erroneous data point)

# ANSWER

#Key: ds <- read_tsv(fnames, skip = 7, col_names = col_names, col_types = "iccl")
      #ds$trial_num_100 <- ds$trial_num + 100

### QUESTION 7 -----

# Now that the column type problem is fixed, take a look at ds
# We're missing some important information (which participant/block each set of trials comes from)
# Read the help file for read_tsv to use the "id" argument to capture that information in the file
# Re-import the data so that filename becomes a column

# ANSWER

#Key: ds <- read_tsv(fnames, skip = 7, col_names = col_names, col_types = "iccl", id = "filename")

# How to get more useful info out of file name?
    #library(tidyr)
    #ds <- ds %>% extract(filename, into = c("id","session"), "(\\d{4})_(\\d{1})") 
#Extract takes a character variable, names of where to put the extracted data,
# and then a regular expression saying what pattern to look for.
# each part in parentheses is one variable to extract
# \\d{4} means 4 digits, \\d{1} means 1 digit

# Or use "separate", which breaks everything by any delimiter (or a custom one)
# data_A/6191_1.txt will turn into:
# data   A   6191   1   txt
# if we only want to keep 6191 and 1, we can put NAs for the rest
    #ds <- ds %>% separate(filename, into = c(NA, NA, "id", "session", NA))

### QUESTION 8 -----

# Your PI emailed you an Excel file with the list of participant info 
# Install the readxl package, load it, and use it to read in the .xlsx data in data_B
# There are two sheets of data -- import each one into a new tibble

# ANSWER
library(readxl)

xl1 <- read_xlsx('data_B/participant_info.xlsx')

#MComment: Partially correct, this is right for sheet 1, but you'd need a second code for sheet 2

#Key: test_dates <- read_xlsx("data_B/participant_info.xlsx", col_names = c("participant", "test_date"), sheet = 2)



