
 library(shiny)
 source("global.R")
 
 shinyServer(
     function(input, output) {
    
# Define a reactive expression for the document term matrix

terms <- reactive({
    
# Change when the "change book" button is pressed...
input$update
    
#The expression given to isolate()is evaluated in the calling environment.
#This means that if you assign a variable inside the isolate(),
#its value will be visible outside of the isolate().
    
isolate({paste(input$summer, input$merchant,input$romeo)

withProgress({

setProgress(message =" Please wait for Processing the book selected...")

getTermMatrix(input$selection)

})

})

})

# Make the wordcloud() function  repeatable to return a wrapped 
#version of that function that always uses the same seed when called.

wordcloud_rep <- repeatable(wordcloud)

output$plot <- renderPlot({
    

    d <- terms()
    
    wordcloud_rep(names(d), d, scale=c(4,0.2),
                  
        min.freq = input$freq, max.words=input$max,
        use.r.layout=FALSE, random.order=FALSE,
        colors=brewer.pal(8,input$colorScheme))

})


    
})




 
 

