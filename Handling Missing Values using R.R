## we need two Libraries 
# 1 VIM ( Visualisation and Imputation of Missing Values )
# 2 mice (Multivariate Imputation via Chained Equations )

### Step 1 import these 2 libraries

library(VIM)
library(mice)
####After calling packages , let's move on to importing data

data_veh <-read.csv("C:\\Users\\dillu\\Documents\\DSA Home Study\\R basics\\DataFiles\\vehicleMiss.csv",header=TRUE)
View(data_veh)

str(data_veh)
summary(data_veh)
is.na(data_veh$Mileage) ##just checking random things

#### lets check data pattern
md.pattern(data_veh)
##md is missing data 
pat<-md.pairs(data_veh)
#The four components in the output value is have the following interpretation:
  
#  list('rr')
#response-response, both variables are observed

#list('rm')
#response-missing, row observed, column missing

#list('mr')
#missing -response, row missing, column observed

#list('mm')
#missing -missing, both variables are missing

# percentage of usable cases to impute row variable from column variable
round(100*pat$mr/(pat$mr+pat$mm))

## Lets do a margin plot
marginplot(data_veh[,c(3,4)])

## lets impute now 

impute_data<-mice(data=data_veh[,c(-1)] , m=3 ,seed=111)
print(impute_data)
impute_data$imp$Mileage

data_veh[c(19:20,1570),]

### after checking few data points I came to conclusion that 2nd Imputation makes sense

##complete 
New_data<-complete(impute_data,2)

md.pattern(New_data)


### we got the below message 
## No need for mice. This data set is completely observed