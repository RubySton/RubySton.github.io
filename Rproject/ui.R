
library(shiny)

shinyUI(fluidPage(
# Application title

titlePanel("Word Cloud"),

sidebarLayout(

# Sidebar with a slider and selection inputs

sidebarPanel(

selectInput("selection", "Choose a book:", 
            
            choices = books),


actionButton("update", "Change Selection"),
             

hr(),

sliderInput("freq",

                "Minimum Frequency:",

                min = 1, max = 50, value = 15),

sliderInput("max",

                "Maximum Number of Words:",

                min = 1, max = 300, value = 100),


selectInput('colorScheme', 'Color Scheme:', 
            choices=c("Dark2", "Accent", "Paired", "Pastel1",
                      "Pastel2", "Set1", "Set2", "Set3")),



dateInput("date","Date:")

),



# Show Word Cloud

mainPanel(
  h5("1.Please wait for selected book to be processed,
        you will see this sentence in the top right corner of main plane 
        during processing."),
  h5("2.Once the processing completed, you can change the color scheme,
       Maximum Number of Words,then Minimum word frequency."),
  h5("3.Select other book from drop menu.Then click Change Selection 
        button, Once that is done, wait for selected book to be 
        processed, then repeat step 2."),
  h5("4. Please click in the date field, then click your visit date."),
    
    
 plotOutput("plot")
    

)

)

))

