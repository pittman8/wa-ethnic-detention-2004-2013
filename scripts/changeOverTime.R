# A visualization of the changes in the number of prisoners over time 
# This could indicate the economical, politial and social chages that
# happened during the past 9 years. 

library(dplyr)
library(tidyr)
library(plotly)
library(broom)

setwd("C:/Users/Kidus/Desktop/INFO 201/Assignments/wa-ethnic-detention-2004-2013")

data <- read.csv(file = './data/Ethnic_Distribution_of_Detention_Population_2004-2013.csv',header = TRUE)
data.with.extra.Col <- read.csv(file = './data/added_column.csv' ,header = TRUE)

full.data <- left_join(data,data.with.extra.Col, by= 'Year')
full.data$Year <- gsub('%','',full.data$Year)

total.num.data <- distinct(full.data,Total.Num.People.in.WA) 
#a <- group_by(full.data,Year) %>% mutate(pop.per.arrested = (Total /  Total.Num.People.in.WA)*100)
changeOverTime <- function(data) {
  
}

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

# separate it by race and calculate the max and min year, the mean people arrested 
combined.data %>% group_by(race) %>% mutate(ave = mean(num), max = max(num), min=min(num)) 

# best fit line and regressioin 
m <- loess(num ~ Year, data = combined.data)

p <- plot_ly(combined.data, x = ~Year, color = I("black")) %>%
  add_markers(y = ~num, text = rownames(combined.data), showlegend = FALSE) %>%
  add_lines(y = ~fitted(loess(num ~ Year)),
            line = list(color = 'rgba(7, 164, 181, 1)'),
            name = "Loess Smoother") %>%
  add_ribbons(data = augment(m),
              ymin = ~.fitted - 1.96 * .se.fit,
              ymax = ~.fitted + 1.96 * .se.fit,
              line = list(color = 'rgba(7, 164, 181, 0.05)'),
              fillcolor = 'rgba(7, 164, 181, 0.2)',
              name = "Standard Error") %>%
  layout(xaxis = list(title = 'Displacement (cu.in.)'),
         yaxis = list(title = 'Miles/(US) gallon'),
         legend = list(x = 0.80, y = 0.90))


# calculate proportion 


