library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel("Washington State Ethnic Detention from 2004-2013"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
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
        in prison for being wrongfully convicted.")))
  ))

