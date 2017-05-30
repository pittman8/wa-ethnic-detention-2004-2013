
# File to display a pie chart of percentages of ethnicities that were detained in WA in 2013
library(plotly)
library(dplyr)

Pie.2013 <- function(data) {
  p <- plot_ly(data.2013.flipped, labels = row.names(data.2013.flipped), values = data.2013.flipped$t.data.2013., type = 'pie') %>%
    layout(title = '2013 Detainee Ethnicity %s in WA State (Hover for Ethnicity)',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)) %>% 
    return()
}
