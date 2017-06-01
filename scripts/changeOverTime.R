# A visualization of the changes in the number of prisoners over time 
# This could indicate the economical, political and social changes that
# happened during the past 9 years. 

library(dplyr)
library(tidyr)
library(plotly)
library(broom)

#setwd("C:/Users/Kidus/Desktop/INFO 201/Assignments/wa-ethnic-detention-2004-2013")

# This function takes in data, search value(race selector), year and num of incarcereated people 
# and generates a scatter plot with a best fit line or model curve that is an approximation of the actual population.
ChangeOverTime <- function(data, search ='', xvar='Year', yvar='num', color='percent') {
  
  # separate it by race and calculate the max and min year, the mean people arrested 
  data <- data %>% filter(grepl(search,race))
  data$Year <-as.numeric(data$Year)

graph <- plot_ly(data = data, x = ~Year, color = I("black")) %>%
       add_markers(y = ~num, text = rownames(data), showlegend = FALSE) %>%
       add_lines(y = ~fitted(loess(num ~ Year)),
                           line = list(color = 'rgba(7, 164, 181, 1)'),
                             name = "Best Fit") %>%
       add_ribbons(data = augment(loess(num ~ Year, data)),
                                     ymin = ~.fitted - 2 * .se.fit,
                                     ymax = ~.fitted + 2 * .se.fit,
                                     line = list(color = 'rgba(7, 164, 181, 0.05)'),
                                     fillcolor = 'rgba(73, 144, 121, 0.3)',
                                     name = "Standard Deviation") %>%
       layout(xaxis = list(title = 'Time'),
                           yaxis = list(title = 'Numbers of People Incarcerated'),
                           legend = list(x = 0.80, y = 0.90)) %>% return()
}




