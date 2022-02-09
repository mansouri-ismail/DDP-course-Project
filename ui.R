
library(shiny)
shinyUI(fluidPage(
    titlePanel("IRIS Flower Prediction App"),
    sidebarLayout(
        sidebarPanel(
            em("Enter the dimensions of the Petal and Sepal width and lenth to predict the species of the flower:"),
            sliderInput("petal.wid","Petal width:",min = 0.1,max =2.5,value = 0.2,step = 0.3),
            sliderInput("petal.len","Petal lenght:",min = 1,max = 6.9,value = 3.4,step = 0.3),
            sliderInput("sepal.wid","Sepal width:",min = 2,max = 4.4,value = 3,step = 0.5),
            sliderInput("sepal.len","Sepal lenght:",min = 4.3,max = 7.9,value = 5.8,step = 0.5),
            em("The Iris flower data set or Fisher's Iris data set is a multivariate data set 
               introduced by the British statistician and biologist Ronald Fisher.source:WikiPedia"),
        ),
        mainPanel(
            h1("The Flower species is:",textOutput("flowername")),
            imageOutput("pic",width = 300,height = 300),
            
            
        )
    )
))
