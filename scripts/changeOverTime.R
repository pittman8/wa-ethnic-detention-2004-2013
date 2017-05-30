# A visualization of the changes in the number of prisoners over time 
# This could indicate the economical, politial and social chages that
# happened during the past 9 years. 

library(dplyr)
library(tidyr)
library(plotly)

data <- read.csv(file = './data/Ethnic_Distribution_of_Detention_Population_2004-2013.csv',header = TRUE)
data.with.extra.Col <- read.csv(file = './data/added_column.csv' ,header = TRUE)

long.data <- gather(data,)


changeOverTime <- function(data) {
  
}

