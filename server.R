library(shiny)
library(plotly)
library(dplyr)

setwd("~/UW/2nd/INFO201/wa-ethnic-detention-2004-2013/")
source('./scripts/2004_pie_chart.R')
source('./scripts/2013_pie_chart.R')

# Data set retrieved from Data.WA.gov
WA.detention.data <- read.csv('./data/Ethnic_Distribution_of_Detention_Population_2004-2013.csv', check.names = FALSE,stringsAsFactors=FALSE)

# Data found from research - total WA population from 2004-2015
total.WA.pop <- read.csv('./data/added_column.csv', check.names = FALSE,stringsAsFactors=FALSE)

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

#WA data
WA.data <- full_join(WA.detention.data, total.WA.pop, by = 'Year')
WA.data <-filter(WA.data,Year %in% c('# 2004','# 2005','# 2006','# 2007','# 2008','# 2009','# 2010','# 2011','# 2012','# 2013'))
WA.data[,-1] <- as.numeric(gsub(",", "", as.matrix(WA.data[,-1])))

shinyServer(function(input, output) {
  output$pie2004 <- renderPlotly({
    return(Pie.2004(data.2004.flipped))
  })
  output$pie2013 <- renderPlotly({
    return(Pie.2013(data.2013.flipped))
  })
  output$totalChart <- renderPlotly({
    if(input$var == 'Total') {
      my.data <- mutate(WA.data,percentage = (Total/`Total Num People in WA`)*100) %>%
        select(Year,percentage)
      return(plot_ly(my.data, x= ~Year,y=~percentage,type='bar',name = 'percentage') %>%
        layout(title ="percentage of detention population in WA" ,yaxis=list(title = 'percentage')))
    } else {
      my.data <- filter(WA.data, Year %in% input$var)
      total.WA <- my.data$`Total Num People in WA`
      my.data <- select(my.data,White,Black,`Native American`,`Asian & Pacific Is.`,Hispanic,`Other/Unknown`,`Total`)
      my.data <- my.data/total.WA *100
      my.data <- data.frame(t(my.data))
      return(plot_ly(my.data, x=row.names(my.data),y=~t.my.data.,name="percentage by ethnicity",type='bar') %>%
               layout(title="percentage of ",yaxis = list(title = "percentage")))
    }
  })
})

