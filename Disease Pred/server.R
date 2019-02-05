library(shiny)
library(datasets)
library(glm2)
library(data.table)
library(DT)
library(rpart)
library(randomForest)
#print(getwd())
tb<-read.csv("TB_Train.csv",header=T,stringsAsFactors=FALSE)
tbframe<-as.data.frame(tb)
#print(tbframe)
tb_rpart<-rpart(as.factor(Is_TB)~.,data=tbframe)
  #summary(tb_rpart)
#View(tb_rpart)
  #print(sapply(tbframe,class))
  #View(b)

pred_tb<-function(Age,Gender,MaritalStatus,FoodPreference,s1,s2,s3,s4,s5,s6,s7){
  
 
  inputdata1<-as.integer(Age)
  i<-suppressWarnings(as.integer(Gender))
  j<-suppressWarnings(as.integer(MaritalStatus))
  k<-suppressWarnings(as.integer(FoodPreference))
  #print(sapply(inputdata1,class))
  inputdata2<-c(i,j,k)#,s1,s2,s3,s4,s5,s6,s7)
  inputdata3<-c(s1,s2,s3,s4,s5,s6,s7)
  
  pred_data1<-as.data.frame(t(inputdata1))
  pred_data2<-as.data.frame(t(inputdata2))
  #colnames(inputdata2)<-c("Symptoms_1","Symptoms_2","Symptoms_3","Symptoms_4","Symptoms_5","Symptoms_6","Symptoms_7")
  #print(inputdata2)
  pred_data3<-as.data.frame(t(inputdata3))
  #print(pred_data)
  op<-cbind(pred_data1,pred_data2,pred_data3)
  #print(input$Gender)
  #print(op)
  colnames(op)<-c("Age","Gender","Marital.Status","Food.Preference","Symptoms_1","Symptoms_2","Symptoms_3","Symptoms_4","Symptoms_5","Symptoms_6","Symptoms_7")
  #sprintf("hi")
  #print(colnames(op))
  #print(sapply(op,class))
  sur_prob<-predict(tb_rpart,op,type="prob")
  #print(sur_prob)
  return(sur_prob)
  
}


function(input, output, session) {
  
  
  observe({   dob <- input$date1
  if(!is.null(dob)) {
    days <- as.integer((Sys.Date() - as.Date(dob)))
    years <- as.integer(days / 365)
    months <- as.integer((days %% 365 ) / 30)
    age <- paste(years)#, 'year(s)', months, 'month(s)') 
    #dobs<-paste( Sys.Date()) 
    #print(sapply(as.integer(age),class))
    #print(age)
    updateTextInput(session, "age", value = age)
    #updateDateInput(session, "dobs", value = dobs)
  }
  
  })
  
  #agedf<-reactive({ input$age <- as.numeric(input$age)  })
  
 
  
 output$prob<-renderText ({pred_tb(input$age,input$sex,input$MS,input$FP,Dataframe2()$Symptoms_1,Dataframe2()$Symptoms_2,Dataframe2()$Symptoms_3,Dataframe2()$Symptoms_4,Dataframe2()$Symptoms_5,Dataframe2()$Symptoms_6,Dataframe2()$Symptoms_7 )})
 
  # 
  # 
  # output$dummy <- renderPrint({
  #   #length(input$sympt)
  #   Dataframe2()
  #   
  #   #sapply(input$age,class)
  #   #sapply(df$Symptoms_1,class)
  #   #sapply(df$Symptoms_2,class)
  #   #sapply(df$Symptoms_3,class)
  #   #sagedf()
  # })
  
  Dataframe2 <- reactive({
    
    mydf<-as.data.frame(input$sympt)
    Symptoms_2<-c(0L)
    Symptoms_3<-c(0L)
    Symptoms_4<-c(0L)
    Symptoms_5<-c(0L)
    Symptoms_6<-c(0L)
    Symptoms_7<-c(0L)
    if (length(mydf)==1)   {
      colnames(mydf)<-c("Symptoms_1")
    c(cbind.data.frame(mydf,Symptoms_2,Symptoms_3,Symptoms_4,Symptoms_5,Symptoms_6,Symptoms_7))
    length(mydf)=1}
    else if(length(df)==2) {
      colnames(df)<-c("Symptoms_1","Symptoms_2")
      c(cbind.data.frame(mydf,Symptoms_3,Symptoms_4,Symptoms_5,Symptoms_6,Symptoms_7))}
    else if(length(df)==3) {
      colnames(df)<-c("Symptoms_1","Symptoms_2","Symptoms_3")
    c(cbind.data.frame(mydf,Symptoms_4,Symptoms_5,Symptoms_6,Symptoms_7))}
    else if(length(df)==4) {
      colnames(df)<-c("Symptoms_1","Symptoms_2","Symptoms_3","Symptoms_4")
    c(cbind.data.frame(mydf,Symptoms_5,Symptoms_6,Symptoms_7))}
    else if(length(df)==5) {
      colnames(df)<-c("Symptoms_1","Symptoms_2","Symptoms_3","Symptoms_4","Symptoms_5")
      c(cbind.data.frame(mydf,Symptoms_6,Symptoms_7))}
    else if(length(df)==6) {
      colnames(df)<-c("Symptoms_1","Symptoms_2","Symptoms_3","Symptoms_4","Symptoms_5","Symptoms_6")
    c(cbind.data.frame(mydf,Symptoms_7))}
    else if(length(df)==7) {
      colnames(df)<-c("Symptoms_1","Symptoms_2","Symptoms_3","Symptoms_4","Symptoms_5","Symptoms_6","Symptoms_7")
    c(mydf)}
      #c(cbind.data.frame(mydf,Symptoms_2,Symptoms_3,Symptoms_4,Symptoms_5,Symptoms_6,Symptoms_7))}
    
    #names(df) 
    
    c(cbind.data.frame(mydf,Symptoms_2,Symptoms_3,Symptoms_4,Symptoms_5,Symptoms_6,Symptoms_7))
    #print(mydf)
    #colnames(mydf)
    
  
  })

  
  #output$ziptable <- DT::renderDataTable({
  #  df <- cleantable
     
      #mutate(Action = paste('<a class="go-map" href="" data-lat="', Lat, '" data-long="', Long, '" data-zip="', Zipcode, '"><i class="fa fa-crosshairs"></i></a>', sep=""))
    #action <- DT::dataTableAjax(session, df)
    
    #DT::datatable(df, options = list(ajax = list(url = action)), escape = FALSE)
  #})
}

