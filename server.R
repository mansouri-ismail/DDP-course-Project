library(shiny)
library(shinydashboard)
data("iris")
library(caret)
library(dplyr)
library(ggplot2)
library(plotly)
library(ggalt)
set.seed(05-02-22)

inTrain <- createDataPartition(y =iris$Species,p = .75,list = FALSE)
train_subset<-iris[inTrain,]
test_subset <-iris[-inTrain,]

control<- trainControl("cv",number = 3)

model_fit<-train(Species ~ .,data = train_subset , method = "lda", control =control)


shinyServer(function(input, output,session) {
  
  result<-reactive({  
    input_df<-data.frame(0)
    setosa=virginica=versicolor<-data.frame(0)
    
    input_df$Sepal.Length[1]<-input$sepal.len
    input_df$Sepal.Width[1] <- input$sepal.wid
    input_df$Petal.Length[1]<-input$petal.len
    input_df$Petal.Width[1] <- input$petal.wid
    
    as.character(predict(model_fit,newdata=input_df))
  
    
     })
  output$sepal<-renderPlot({
    
      species<-result()
     
      select_species<- iris %>% filter(Species == species)
      
      ggplot(data = iris,aes(Sepal.Length,Sepal.Width)) + 
      geom_point(color="blue")+
        geom_encircle(aes(Sepal.Length,Sepal.Width), 
                      data=select_species, 
                      color="red", 
                      size=2, 
                      expand=0.08)+
        labs(subtitle="Sepal Length Vs Sepal Width", 
             y="Sepal Width", 
             x="Sepal Length", 
             title=paste("Sepal Dimensions of",result(),"Species")
             )
     
      })
  output$petal<-renderPlot({
    
    species<-result()
    
    select_species<- iris %>% filter(Species == species)
    
    ggplot(data = iris,aes(Petal.Length,Petal.Width)) + 
      geom_point(color="blue")+
      geom_encircle(aes(Petal.Length,Petal.Width), 
                    data=select_species, 
                    color="red", 
                    size=2, 
                    expand=0.08)+
      labs(subtitle="Petal Length Vs Petal Width", 
           y="Petal Width", 
           x="Petal Length", 
           title=paste("Petal Dimensions of",result(),"Species")
      )
    
  })
  
  output$pic<- renderImage({
    list(src=paste0(result(),".png"))},deleteFile = FALSE)
  
  output$flowername <- renderText(exp=result())
  output$def<-reactive({switch(result(),
                     setosa="Iris setosa, the bristle-pointed iris, is a species of flowering plant in the genus Iris of the family Iridaceae, it belongs the subgenus Limniris and the series Tripetalae.",
                     versicolor="Iris versicolor is also commonly known as the blue flag, harlequin blueflag, larger blue flag, northern blue flag, and poison flag, plus other variations of these names, and in Britain and Ireland as purple iris. It is a species of Iris native to North America, in the Eastern United States and Eastern Canada.",
                     virginica="Iris virginica, with the common name Virginia iris, is a perennial species of flowering plant, native to eastern North America. It is common along the coastal plain from Florida to Georgia in the Southeastern United States."
                     )})
  
  
})
