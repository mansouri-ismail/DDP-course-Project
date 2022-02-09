
library(shiny)
data("iris")
library(caret)
library(randomForest)
library(dplyr)
set.seed(05-02-22)
inTrain <- createDataPartition(y =iris$Species,p = .75,list = FALSE)
train_subset<-iris[inTrain,]
test_subset <-iris[-inTrain,]

control<- trainControl("cv",number = 3)

model_fit<-train(Species ~ .,data = train_subset , method = "rf", control =control)

shinyServer(function(input, output) {
  
  result<-reactive({  
  input_df<-data.frame(0)
  setosa=virginica=versicolor<-data.frame(0)
  
  input_df$Sepal.Length[1]<-input$sepal.len
  input_df$Sepal.Width[1] <- input$sepal.wid
  input_df$Petal.Length[1]<-input$petal.len
  input_df$Petal.Width[1] <- input$petal.wid
  
  as.character(predict(model_fit,newdata=input_df))

 
               
   
  })
  
 output$pic<- renderImage({
                list(src=paste0(result(),".png"))},deleteFile = FALSE)
  output$flowername <- renderText(exp=result())
  
  

})
