library(ggplot2)
library(GGally)
library(dplyr)
library(corrplot)
library(MASS)
library(stringr)
library(tidyr)

# 1 Loading & writing the data

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

write.table(BPRS, file= "/Users/ville/Documents/IODS-project/data/BPRS")
write.table(RATS, file= "/Users/ville/Documents/IODS-project/data/RATS")

str(RATS)
str(BPRS)

summary(RATS)
summary(BPRS)

"BPRS data has 40 observations and d11 variables, 
the RATS data has 16 observations and 13 variables. BPRS data has treatment and subject variables and the variables of each timeframe
as week(n), RATS  data has the ID and Group variables and also WD variables of weight on each timeframe"


# 2 Categorical variables to factors

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# 3 Converting to long from and adding week and time variables

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))

# 4 analysing the long form datasets

str(BPRS)
str(BPRSL)

str(RATS)
str(RATSL)


"From the data structures we can see that the data changes drastically in when its transformed into long form.
Now we can analyze the same participant ID's in different time spots and see how a target variable of brief psychiatric rating scale (BPRS),
or rats weight changes over time, and what has affected the change). The analysis cannot be done on the preliminary data frames as the time frames were not connected to specific ID's  "


write.table(BPRSL, file= "/Users/ville/Documents/IODS-project/data/BPRSL")
write.table(RATSL, file= "/Users/ville/Documents/IODS-project/data/RATSL")


