 "**Ville Aro, 10.11.2019**"
 
 #1) Reading the data
 
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt ", sep="\t", header=TRUE )
 
learning2014

install.packages("dplyr")
 
library(dplyr)
 #2) wrangling variables
 
 deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
 surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
 strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
 
 deep_columns <- select(learning2014, one_of(deep_questions))
 learning2014$deep <- rowMeans(deep_columns)

 surface_columns <- select(learning2014, one_of(surface_questions))
 learning2014$surf <- rowMeans(surface_columns)
 
 strategic_columns <- select(learning2014, one_of(strategic_questions))
 learning2014$stra <- rowMeans(strategic_columns)
 
learning2014$Attitude <- learning2014$Attitude / 10

learning2014 <- filter(learning2014, Points > 0)

length(learning2014$Points)


learning2014
 

# 3) creating analysis dataset

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

superdata <- select(learning2014, one_of(keep_columns))

str(superdata)
head(superdata)

# 4) saving the working directory

write.table(superdata, file= "/Users/ville/Documents/IODS-project/data/Create_learning2014")


str(analyysidata)
head(analyysidata)


