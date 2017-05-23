library(shiny)
library(plotly)
library(dplyr)

setwd('C:/Users/Hannah/Desktop/INFO-201/wa-ethnic-detention-2004-2013')
source('./scripts/proportion_detained_from_total.R')
WA.detention.data <- read.csv('./data/Ethnic_Distribution_of_Detention_Population_2004-2013.csv')
total.WA.pop <- read.csv('./data/added_column.csv')
all.data <- full_join(WA.detention.data, total.WA.pop, by = 'Year')

shinyServer(function(input, output) {
  
  return()
})

