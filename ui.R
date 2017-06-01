#This ui file creates the structure of the shiny web

library(shiny)
library(plotly)
library(dplyr)

#setwd("~/UW/2nd/INFO201/wa-ethnic-detention-2004-2013/")
setwd("C:/Users/Kidus/Desktop/INFO 201/Assignments/wa-ethnic-detention-2004-2013")
WA.detention.data <- read.csv('./data/Ethnic_Distribution_of_Detention_Population_2004-2013.csv', check.names = FALSE)
total.WA.pop <- read.csv('./data/added_column.csv', check.names = FALSE)
all.data <- full_join(WA.detention.data,total.WA.pop)
WA.data <- filter(all.data,Year %in% c('# 2004','# 2005','# 2006','# 2007','# 2008','# 2009','# 2010','# 2011','# 2012','# 2013'))
shinyUI(fluidPage(
  titlePanel("Washington State Ethnic Detention from 2004-2013"),
  #creates tabs in shiny
  navbarPage("Navbar!",
    tabPanel("Main",
      fluidRow(
        p("This dataset is the Ethnic Distribution of Detention Population in Washington State from 2004-2013. 
           The ethnicities used in this dataset are White, Black, Asian & Pacific Islander, Hispanic, and Other/Unknown.
           The dataset includes the number of people of each ethnicity that was detained, as well as the percentage of the 
           total number of people detained each year that is each ethnicity. This dataset was created by Alysa Kipersztok, 
           and corresponds to Table 82 from the Washington State Partnership Council on Juvenile Justice (WA-PCJJ), 2014 edition, 
           provided by the Office of Juvenile Justice. This dataset was created on December 26th, 2015 and was last updated on January 12th, 2016 from Data.WA.gov.
           We have added our own researched information on the total number of people living in Washington from 2004-2013. This extra data was 
           retrieved from Washington State's Office Of Financial Managements' website."), 
        br(),
        p("We wanted to target two specific audiences with this application and the dataset that we are using. One target audience is the 
          Washington state justice system, or police in charge of arrests and putting people in jail. They can learn a lot from this dataset about
          patterns that can be found amongst certain ethnicities and can base the statistics of the people they arrest on this dataset to reveal
          any patterns or insights into who they arrest more or less. More importantly, our main target audience is the general public. The reason 
          is that many people don't realize that the prison system in America is a massive pillar to the economy. There are many stages before a person 
          can be convicted of a crime, proven guilty and sent to prison for rehabilitation as it should be. However, with the current system, many people 
          are convicted of a crime and their cases end up in prosecution which offers them to plead guilty of a crime that they did not commit and serve
          a short amount of time or take their cases to trial and if they lose the case. They serve an extensive amount of time in prison for having the 
          audacity to challenge the system and the prosecutor in trial. These stages require money from the person who is accused of a crime and is fighting 
          for their freedom in court. In prison, convicts are required to work for free for big corporations without knowing it (e.g Victoria Secret, JCPenney).
          These corporations are lobbying to correctional facility owners, and lawmakers. This is a giant economic loop. By having this data analysis and visualizations,
          the public can be aware of the dark side of the system and fight for justice before someone has fallen victim to the system and wastes their entire life
          in prison for being wrongfully convicted."),
        plotlyOutput("pie2004"),# display 2004 pie chart
        plotlyOutput("pie2013"), # display 2013 pie chart
        p("As you can see from the pie charts above, there was a significant change in the percentage of people detained for some ethnicities in Washington state. The ethnicities who saw an overall
          decrease in the overall proportino of people detained were the white ethnicity with a 10% decrease (a very significant decrease!), and the Asian & Pacific Islander and the 
          Unknown/Other ethnicities saw a 1% decrease. However, the Hispanic population had a significant 8% increase in percentage detained of the total number of people detained in a year.
          The black population also saw a pretty significant increase of 3% when comparing the percantages from nine years apart. Finally, the Native American proportion of detainees increased by 1% 
          when comparing 2004 and 2013."),
        p("These results pose significant questions to the audience and force them to consider outside factors that made these percentages decrease or increase. The fact that a significant amount of more Hispanics and African Americans 
           and less White people were detained more recently than further in the past may reveal growing biases that the police and the justice system may consciously or subconsciously have towards these groups.")
        )
      ),
      tabPanel("Percentage of detainees in WA",
        sidebarLayout(
          sidebarPanel(
               selectInput('var','Year:',list('Total','# 2013','# 2012','# 2011','# 2010','# 2009','# 2008','# 2007','# 2006','# 2005','# 2004'))
          ),
          mainPanel(
              plotlyOutput("totalChart"),#display a bargraph
              p("As you can see from the bar graph above, the ratio of detainees to the Washington population decreased by 0.23% between 2004 and 2013. This shows that there will be a lower percentage of detainees in Washington state in the future."),
              br(),
              p("Each year, White population had the highest detainee percentage in WA than other ethnicities. Followed by Hispanic, Black, and others. While the percentage of other ethnicities did not change as much, the percentage of White decreased significantly throughout past few years.")
          )
        )
        ),tabPanel("Change over time",
                   sidebarLayout(
                     sidebarPanel(
                       selectInput('search', label="Race", choices = list('White'='White',
                                                                                 'Black'='Black', 'Native American'='Native.American',
                                                                                 'Asian & Pacific Islander'='Asian...Pacific.Is.', 'Hispanic'='Hispanic', 'Other/Unknown'='Other.Unknown'
                                                                                 ))
                     ),
                     mainPanel(
                       plotlyOutput("ChangeOvTime"), 
                       br(),
                       h4('Summary'),p("   The overall distribution of each graph that is categorized by race shows that there is a decrease in number of incarcerated population. 
                         This could be due to criminal justice system reforms, president Obama's pardon grants and other factors that play a role in 
                          decreasing the number of imprisoned population."), br(),
                          p("The standard deviation suggests a broad range of values that infer
                          to where the actual number of people who are and have been incarcerated is. Using the best fit line or the line that smoothly 
                          shapes the overall distribution, we can tell the exact distribution of imprisoned people."),
                       p('This analysis suggests that there is a decrease in the number of incarcerated population which is a positive change over time. However, the criminal justice system needs a major reform in terms of inmate treatment, bias sentencing, and exploitation of the free labor of inmates.')
                     )
                   )
        )
  )
      )
    )
  
