library(dplyr)


disease_train<-read.csv("tt.csv")
b<-data.frame(disease_train)
disease_test<-read.csv("TB_Test.csv")


cleantable <- disease_train %>%
  select(
   # Age = Age,
    Gender = Gender,
    Food.Preference = Food.Preference,
    Marital.Status = Marital.Status,
    Symptoms_1 = Symptoms_1,
    Symptoms_2 = Symptoms_2,
    Symptoms_3 = Symptoms_3,
    Symptoms_4 = Symptoms_4,
    Symptoms_5 = Symptoms_5,
    Symptoms_6 = Symptoms_6,
    Symptoms_7 = Symptoms_7
  )

