#1) Create a new R script called create_human.R

library(ggplot2)
library(dplyr)


#2) Reading the Human  development and Gender inequality datas into R.

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)  

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#3) Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables. 

str(hd)
summary(hd)
str(gii)
summary(gii)

#4) Renaming the variables with (shorter) descriptive names.


colnames(hd)[3] <- "HDI" 
colnames(hd)[4] <- "life_expect"
colnames(hd)[5] <- "yeducation"
colnames(hd)[6] <- "mean_education"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI.rank"


colnames(hd)


colnames(gii)[3] <- "GII_Index"
colnames(gii)[4] <- "M_Mortality"
colnames(gii)[5] <- "B_rate"
colnames(gii)[6] <- "Parliament"
colnames(gii)[7] <- "Edu_F"
colnames(gii)[8] <- "Edu_M"
colnames(gii)[9] <- "LParticipation_F"
colnames(gii)[10] <- "LParticipation_M"

summary(gii)

# 5) Mutating the variables 

gii <- mutate(gii, edu_ratio = (Education_F/Education_M))
gii <- mutate(gii, participation_ratio = (LParticipation_F/LParticipation_M))

# 6) Joining the datasets by "Country"-column

join_by <- c("Country")

human <- inner_join(gii, hd, by = join_by, suffix = c(".gii", ".hd"))

glimpse(human)

write.table(human, file= "/Users/ville/Documents/IODS-project/data/human")

"After the joining the dataset has 195 observations and 19 variables"
