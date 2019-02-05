library(shiny)
library(datasets)

#library(xlsx)


navbarPage("Superzip", id="nav",
           
           tabPanel("Interactive map",
                    div(class="outer",
                      
                        
                                      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      
                                      h2("Disease Prediction"),
                                      
                                      #selectInput("color", "Color", vars),
                                      #selectInput("size", "Size", vars, selected = "adultpop"),
                                      fluidPage(
                                      dateInput("date1", "DOB:", value = "2012-02-29")),
                                      textInput("age",label = "AGE:"),
                                     
                                      
                                      fluidPage(
                                        radioButtons("sex", "Gender:",
                                                     c("Male" = "M",
                                                       "Female" = "F"
                                                     ))
                                       
                                      ),
                                      
                                    

                                      fluidPage(
                                        radioButtons("MS", "Marital Status:",
                                                     c("Single" = "Single",
                                                       "Married" = "Married"
                                                     ))
                                       
                                      ),
                                      fluidPage(
                                        radioButtons("FP", "Food Preference:",
                                                     c("Non Veg" = "Nonveg",
                                                       "Veg" = "Veg"
                                                     ))
                                        
                                      ),
                                    
                                  
                                      
                                     fluidPage(
                                       checkboxGroupInput(inputId ='sympt',
                                                     label = "Symptoms:",
                                                     choices = list( "Cough"=1, "Cough With blood"=2,
                                                                 "Headache"=3
                                                                 ,"Fever"=4,"Night sweat"=5,"constant tiredness"=6,"unexplained weight loss"=7),
                                                     selected = 1) 
                                       
                                              )
                                     ,
                                     
                                     
                                     
                                     verbatimTextOutput("dummy")
                                    
                                    #, submitButton('Submit')
                                      
                        )
                        
                       
                    )
                    
           ),
           
         

        
           mainPanel(
             h3("Disease prob"),
             h4(textOutput('prob')),
             uiOutput('table')
           )
           
           #conditionalPanel("false", icon("crosshair")),
           
           
           
         
)



