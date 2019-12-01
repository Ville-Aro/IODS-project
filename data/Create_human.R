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

gii <- mutate(gii, edu_ratio = (Edu_F/Edu_M))
gii <- mutate(gii, participation_ratio = (LParticipation_F/LParticipation_M))

# 6) Joining the datasets by "Country"-column

join_by <- c("Country")

human <- inner_join(gii, hd, by = join_by, suffix = c(".gii", ".hd"))

glimpse(human)

write.table(human, file= "/Users/ville/Documents/IODS-project/data/human")

"After the joining the dataset has 195 observations and 19 variables"

# Data wrangling continues for excercise 5

# 1 GNI To numeric and data description

library(stringr)
library(MASS)


str(human)

human$Country

"The dataset has 19 variables measuring wellbeing and gender inequality in 188 countires and 7 regions

HDI = Measures human development index, 
life_expect=measures life expectancy at birth, 
yeducation=  Expected years of schooling,
mean_education= mean of yeas of education,
GNI= Gross national income per capita, 
GNI rank= rank of GNI per country,
GII= Gender inequality index,
M_Mortality= maternal mortality rate,
B_rate= Birht rate
Parliament = Percetange of female representatives in parliament
Edu_F = Proportion of females with at least secondary education
Edu_M = Proportion of males with at least secondary education
LParticipation_F = Proportion of females in the labour force
LParticipation_M  Proportion of males in the labour force"

install.packages("stringr", repos="http://cran.us.r-project.org")
library(stringr)

human_$GNI <- str_replace(human_$GNI, pattern=",", replace ="") %>% as.numeric()


# 2 Excluding unneeded variables

keep <- c("Country", "edu_ratio", "participation_ratio", "life_expect",
          "yeducation", "GNI", "M_Mortality", "B_rate", "Parliament")

human <- dplyr::select(human, one_of(keep))


# 3 removing missing values

complete.cases(human)

human_ <- filter(human, complete.cases(human))

str(human_)

# 4 Removing observations relating to regions
last <- nrow(human_) - 7
human_ <- human_[1:last,]

# Defining the row names and removing country columns

rownames(human_) <- human_$Country

human_ <- dplyr::select(human_, -Country)

str(human_)

str_replace(human_$GNI, pattern=",", replace ="") %>% as.numeric
write.table(human_, file= "/Users/ville/Documents/IODS-project/data/human_")
