#This server file creates the data that will be showing in shiny app
library(shiny)
library(plotly)
library(dplyr)
library(broom)

#setwd('C:/Users/Hannah/Desktop/INFO-201/wa-ethnic-detention-2004-2013')
setwd("~/UW/2nd/INFO201/wa-ethnic-detention-2004-2013")
# setwd("C:/Users/Kidus/Desktop/INFO 201/Assignments/wa-ethnic-detention-2004-2013")

source('./scripts/2004_pie_chart.R')
source('./scripts/2013_pie_chart.R')
source('./scripts/changeOverTime.R')

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




# Data wrangling for changeOverTime program 
# -----------------------------------------------------------------------------------------------------
data <- read.csv(file = './data/Ethnic_Distribution_of_Detention_Population_2004-2013.csv',header = TRUE)
data.with.extra.Col <- read.csv(file = './data/added_column.csv' ,header = TRUE,stringsAsFactors=FALSE)

full.data <- left_join(data,data.with.extra.Col, by= 'Year')
full.data$Year <- gsub('%','',full.data$Year)

total.num.data <- distinct(full.data,Total.Num.People.in.WA) 

percentage <- filter(full.data, Year %in% c('2004', '2005' ,'2006', '2007', '2008', '2009', '2010' ,'2011', '2012','2013'))

num.of.arrested <- filter(full.data, Year %in% c('# 2004', '# 2005' ,'# 2006', '# 2007', '# 2008', '# 2009', '# 2010' ,'# 2011', '# 2012','# 2013'))

percentage$Total.Num.People.in.WA <- NULL

long.percentage <- percentage %>% gather(race,per,White:Other.Unknown)
colnames(long.percentage)[2] <- 'Total.percentage'

long.num.arrest <- num.of.arrested %>% gather(race,num,White:Other.Unknown)
long.num.arrest$Year <-gsub('#','',long.num.arrest$Year)

# Join these two data frames together and create one long one. 
combined.data <- left_join(long.num.arrest, long.percentage, by = c('Year','race'))

combined.data$Total <- gsub(',','',combined.data$Total)
combined.data$num <- gsub(',','',combined.data$num)

combined.data$Total <- as.numeric(combined.data$Total)
combined.data$num <- as.numeric(combined.data$num)

combined.data$percent <- round((combined.data$num / combined.data$Total) * 100, 1)

combined.data$Total.percentage <- NULL
combined.data$per <- NULL

#--------------------------------------------------------------------------------------------------

shinyServer(function(input, output) {
  #creates the piechart from 2004 data
  output$pie2004 <- renderPlotly({
    return(Pie.2004(data.2004.flipped))
  })
  #creates the pichart from 2013 data
  output$pie2013 <- renderPlotly({
    return(Pie.2013(data.2013.flipped))
  })
  #creates the bargraph of detainees / total population in WA
  output$totalChart <- renderPlotly({
    #returns percentage from 2004 to 2013
    if(input$var == 'Total') {
      my.data <- mutate(WA.data,percentage = (Total/`Total Num People in WA`)*100) %>%
        select(Year,percentage)
      return(plot_ly(my.data, x= ~Year,y=~percentage,type='bar',name = 'percentage') %>%
        layout(title ="percentage of detainees in WA from 2004 to 2013" ,yaxis=list(title = 'percentage')))
    } else {
      #returns the bargraph of percentage by ethnicity in each year
      my.data <- filter(WA.data, Year %in% input$var)
      total.WA <- my.data$`Total Num People in WA`
      my.data <- select(my.data,White,Black,`Native American`,`Asian & Pacific Is.`,Hispanic,`Other/Unknown`,`Total`)
      my.data <- my.data/total.WA *100
      my.data <- data.frame(t(my.data))
      return(plot_ly(my.data, x=row.names(my.data),y=~t.my.data.,name="percentage by ethnicity",type='bar') %>%
               layout(title="percentage of detainee in WA by ethnicity",yaxis = list(title = "percentage")))
    }
  })
  
  output$ChangeOvTime <- renderPlotly({
    return(ChangeOverTime(combined.data,input$search, 'Year','num','percent'))
  })
})

