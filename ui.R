library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
data("iris")
library(caret)
library(dplyr)
library(ggalt)


flowers<-unique(iris$Species)
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Prediction App",tabName = "pred",icon = icon(name="play-circle",lib ="glyphicon" )),
    menuItem("Documentation", icon = icon(name="align-justify",lib ="glyphicon" ), tabName = "doc")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "pred",
            fluidRow(
              box(width = 8,h1(textOutput("flowername")),
                  h5(textOutput("def")),
                  imageOutput("pic",width = 300,height = 300)),
              box(width = 4,
                h5("Enter the dimensions of the Petal and Sepal width and lenth to predict the species of the flower:"),
                sliderInput("petal.wid","Petal width:",min = 0.1,max =2.5,value = 0.2,step = 0.1),
                sliderInput("petal.len","Petal lenght:",min = 1,max = 6.9,value = 3.4,step = 0.1),
                sliderInput("sepal.wid","Sepal width:",min = 2,max = 4.4,value = 3,step = 0.2),
                sliderInput("sepal.len","Sepal lenght:",min = 4.3,max = 7.9,value = 5.8,step = 0.2)
              )
            ),
            fluidRow(box(
              plotOutput("sepal")
            ),
            box(plotOutput("petal"))
            )
            ),
            
    tabItem(tabName = "doc",
            
            includeHTML("Documentation.html"))
    
   
          
  )
)


ui <- dashboardPage(skin = "purple",
  dashboardHeader(disable = TRUE),
  sidebar,
  body
)