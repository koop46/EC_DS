
library(ggplot2)

Kidata <- read.csv('~/R projekt/kidney_disease.csv', stringsAsFactors = FALSE, sep=",")


########################################### Pre-processing ###########################################

Kidata$pcv[Kidata$pcv == "\t43"] <- 43
Kidata$pcv[Kidata$pcv == "\t?"] <- NA
Kidata$wc[Kidata$wc == "\t6200"] <- 6200
Kidata$wc[Kidata$wc == "\t8400"] <- 8400
Kidata$wc[Kidata$wc == "\t?"] <- NA
Kidata$wc[Kidata$wc == "\t?"] <- NA
Kidata$dm[Kidata$dm == "\tyes"] <- "yes"
Kidata$dm[Kidata$dm == "\tno"] <- "no"
Kidata$cad[Kidata$cad == "\tno"] <- "no"
Kidata$classification[Kidata$classification == "ckd\t"] <- "ckd"

########################################### Format & means ############################################


Kidata$id = as.integer(Kidata$id)                                                 ############# integer


num.cnv = function(){                                                             ############# numerics 
  
  nums = c('age', 'bp', 'sg', 'al', 'su', 'bgr', 'bu', 'sc', 'sod', 'pot', 'hemo','pcv', 'wc','rc')
  
  for (i in colnames(Kidata)){
    for (ii in nums){
      
      if (i == ii){
        Kidata[[i]] <<- as.numeric(Kidata[[i]])

      }
    }
  }
}  


med = function(){                                                                     ############# mean
  
  mds = c('age', 'bp', 'sg', 'al', 'su', 'bgr', 'bu', 'sc', 'sod', 'pot', 'hemo', 'pcv', 'wc', 'rc')
  
  
  for (i in colnames(Kidata)){
    for (ii in mds){
      
      if (i == ii){
        medel = as.integer(mean(Kidata[[i]], na.rm = TRUE))
        Kidata[[i]][is.na(Kidata[[i]])] <<- medel

      }
    }
  }
}  


chr.cnv = function(){                                                                 ############# char
  
  chrs = c('rbc', 'pc', 'pcc', 'ba', 'pcv', 'wc', 'rc', 'htn', 'dm', 'cad', 'appet', 'pe', 'ane', 'classification')
  
  
  for (i in colnames(Kidata)){
    for (ii in chrs){
      
      if (i == ii){
        Kidata[[i]] <<- as.character(Kidata[[i]])

      }
    }
  }
}  

########################################### Encode ############################################


enc.data = function(x){ 
  
  enc = c('rbc', 'pc', 'pcc', 'ba','htn', 'dm', 'cad', 'appet', 'pe', 'ane', 'classification')
  
  for (i in colnames(Kidata)){
    
    Kidata[[i]][is.na(Kidata[[i]])] <- 0
    
    
    if (i == 'htn' | i == 'cad' | i == 'dm' | i == 'pe' | i == 'ane'){
      Kidata[[i]] <<- factor(Kidata[[i]], levels = c('yes', 'no'), labels = c(1,0))
        
    }
      
    else if(i == 'pc' | i == 'rbc'){
      Kidata[[i]] <<- factor(Kidata[[i]], levels = c('normal', 'abnormal'), labels = c(1,0))
        
    }
    else if(i == 'pcc' | i == 'ba'){
      Kidata[[i]] <<- factor(Kidata[[i]], levels = c('present', 'notpresent'), labels = c(1,0))
        
    }
    else if(i == 'appet'){
      Kidata[[i]] <<- factor(Kidata[[i]], levels = c('good', 'poor'), labels = c(1,0))
        
    }
    else if(i == 'classification'){
      Kidata[[i]] <<- factor(Kidata[[i]], levels = c('ckd', 'notckd'), labels = c(1,0))
        
    }
  }

      
}

  
########################################### ~Execute~ ############################################


exe.cute = function(){
  

  enc.data()
  num.cnv()
  med()
  chr.cnv()

}


exe.cute()

########################################### ~Ploting~ ############################################



#bar
graf <- ggplot(Kidata[which(Kidata$age>40),], aes(x=age, y=bgr))
graf + geom_col(fill="orange")+labs(x="Age", y="Blood Glucose Random",title="Blood glucose random after 40")



# #point
graf1 <- ggplot(Kidata[which(Kidata$age<35),], aes(x=age, y=sg))
graf1 + geom_point(aes(col=age, size=1))+labs(x="Age", y="Specific Gravity",title="Specific gravity under 35 years of age")

#scatter
graf2 <- ggplot(Kidata[which(Kidata$age>35 & Kidata$age<55 ),],aes(x=age, y=hemo))
graf2 + geom_point(colour="red",size=2, shape=17) + labs(x="Age", y="Hemoglobin", title="Hemoglobin in ages between 35 and 55")


View(Kidata)






