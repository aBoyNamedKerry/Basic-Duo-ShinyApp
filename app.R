#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(DT)
library(shinythemes)

lang_data <- read_rds("./Data/lang_data.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Who's learning languages"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
        h3("Make your choice"),
        
         selectInput(inputId = "lang_choice", label = "Choose user langauge", 
                     choices = levels(lang_data$ui_language),
                     multiple = TRUE, selectize = TRUE, selected = "en")
      ),#end of sidebar panel
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(type = "tabs",
          tabPanel(title = "Plot",
            plotOutput("barplot")),
          
          tabPanel(title = "Data table",
                   br(),
                   h3("Ratio of correct correct guesses versus words seen"),
                   DT::dataTableOutput(outputId = "success_table"))
        )#end of tabset panel
      )# end of main panel
      
   )# end of sidebarLayout
, theme = shinytheme("cerulean"))# end of fluid page


# Define server logic required to draw a histogram
server <- function(input, output) {
   
  #creative reactive
    user_lang <- reactive({
      req(input$lang_choice)
      lang_data %>% filter(ui_language %in% input$lang_choice) %>%
      group_by(user_id, learning_language) %>%
      summarise(overall_correct_ratio = round(sum(history_correct) / sum(history_seen), 2))
    
  })# end of reactive
  
    #create bar plot for languages being learnt
     output$barplot <- renderPlot({
       
      user_lang() %>%
         count(learning_language) %>%
         ggplot(data =.) +
         geom_bar(aes(x = learning_language, y = n, fill = learning_language), stat = "identity")
   })# end of render plot
     
     #create data table of success rate
     output$success_table<- DT::renderDataTable(
       
       user_lang() %>%
         group_by(learning_language) %>% summarise(avg_correct = round(mean(overall_correct_ratio),2))
     )# end of render table
}

# Run the application 
shinyApp(ui = ui, server = server)

