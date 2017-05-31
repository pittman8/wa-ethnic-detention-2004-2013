library(shiny)
library(plotly)
library(dplyr)

#setwd('C:/Users/Hannah/Desktop/INFO-201/wa-ethnic-detention-2004-2013')
source('./scripts/2004_pie_chart.R')
source('./scripts/2013_pie_chart.R')

# Data set retrieved from Data.WA.gov
WA.detention.data <- read.csv('./data/Ethnic_Distribution_of_Detention_Population_2004-2013.csv', check.names = FALSE)

# Data found from research - total WA population from 2004-2015
total.WA.pop <- read.csv('./data/added_column.csv', check.names = FALSE)

# Join data sets
all.data <- full_join(WA.detention.data, total.WA.pop, by = 'Year')

# Remove unneeded columns
all.data$Total <- NULL
all.data$`Total Num People in WA` <- NULL

# Remove percent signs
all.data$White <- gsub("%", "", all.data$White)
all.data$Black <- gsub("%", "", all.data$Black)
all.data$`Native American` <- gsub("%", "", all.data$`Native American`)
all.data$Hispanic <- gsub("%", "", all.data$Hispanic)
all.data$`Asian & Pacific Is.` <- gsub("%", "", all.data$`Asian & Pacific Is.`)
all.data$`Other/Unknown` <- gsub("%", "", all.data$`Other/Unknown`)

# 2004 pie chart set up
data.2004 <- all.data %>% filter(Year == "2004%")
data.2004$Year <- NULL # unneeded column now
# Flip rows with columns 
data.2004.flipped <- data.frame(t(data.2004))

# 2013 pie chart set up
data.2013 <- all.data %>% filter(Year == "2013%")
data.2013$Year <- NULL # unneeded column now
data.2013.flipped <- data.frame(t(data.2013))


shinyServer(function(input, output) {
  output$pie2004 <- renderPlotly({
    return(Pie.2004(data.2004.flipped))
  })
  output$pie2013 <- renderPlotly({
    return(Pie.2013(data.2013.flipped))
  })
})

