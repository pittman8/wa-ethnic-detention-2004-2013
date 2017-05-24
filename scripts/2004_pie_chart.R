# File to display a pie chart of percentages of ethnicities that were detained in WA in 2004
library(plotly)
library(dplyr)

Pie.2004 <- function(data) {
p <- plot_ly(data.2004.flipped, labels = row.names(data.2004.flipped), values = data.2004.flipped$t.data.2004., type = 'pie') %>%
  layout(title = '2004 Detainee Ethnicity %s in WA State (Hover for Ethnicity)',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)) %>% 
  return()
}
