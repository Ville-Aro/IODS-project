#ville Aro, 17.11.2019, data wrangling

# data available at: https://archive.ics.uci.edu/ml/datasets/Student+Performance



#Reading the data

url <- "/Users/ville/Documents/IODS-project/data"

url_math <- paste(url, "student-mat.csv", sep = "/")

math <- read.table(url_math, sep = ";" , header=TRUE)

url_por <- paste(url, "student-por.csv", sep = "/")

por <- read.table(url_por, sep = ";", header = TRUE)

str(por)

str(math)

"Por Data has 649 observations and 33 different variables. Math data has 395 observations and also 33 variables"


#Joining the datasets
install.packages(dplyr)

library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

glimpse(math_por)

str(math_por)


"The new dataset has 382 observations and 53 variables"

#Removing duplicates

alc <- select(math_por, one_of(join_by))


notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

for(column_name in notjoined_columns) {
  
two_columns <- select(math_por, starts_with(column_name))  

first_column <- select(two_columns, 1)[[1]]


if(is.numeric(first_column)) { alc[column_name] <- round(rowMeans(two_columns))} else { alc[column_name] <- first_column }}

glimpse(alc)  

"With the duplicates removed the data now has 382 observations and 33 variables"

#Creating alchol consumption variables.

install.packages(ggplot2)
library(ggplot2)

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

"Dataset is complete as we have 382 observations and 35 variables"

write.table(alc, file= "/Users/ville/Documents/IODS-project/data/alc")

            