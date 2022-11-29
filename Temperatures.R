
temppp = function(){
  
  SS = c("San Salvador")
  B = c("Benghazi")
  O = c("Orebro")
  R = c("Rio")
  BE = c("Beijing")
  M = c("Moscow")
  RO = c("Roma")
  MO = c("Mogadishu")
  AA = c("Addis Abbaba")
  TE = c("Tehran")
  
  ALL = list(SS,B,O,R,BE,M,RO,MO,AA,TE)
  cond = TRUE
  tmpd = as.integer(readline("Hur många dagar vill du beräkna?"))
  
  ################################ Menu loop #########################################################
  while (cond) {
    for (C in 1:10){
      if (length(ALL[[10]]) <= tmpd){####################ask for input, amount of times as prompted first
        
        cat("Vilken temp i",ALL[[C]][1])
        temperature = as.integer(readline(prompt = ""))
        
        ALL[[C]] <- c(ALL[[C]],temperature)
        
      }  
      else {
        
        cond = FALSE
      
      }
    }
  }
  
################################ calculate max temp#########################################################
  for (i in 1:10){ #####################loop through list
    
    built_in_max = c()######################vector for built in
    storsta = strtoi(ALL[[i]][2])
    
    for (ii in 2:(tmpd+1)){#####################loop through vectors inside list
      built_in_max = c(built_in_max, ALL[[i]][ii])
      
      if (ALL[[i]][ii] > storsta) {
        
        storsta = strtoi(ALL[[i]][ii])
        
      }
    }
    
    cat("Highest temp for",ALL[[i]][1])
    print(storsta)
    cat("Highest built-in ---> ", max(built_in_max),"\n")
    
  }
  cat("\n")###########################################
################################ Minimum temperature ######################################################
  for (i in 1:10){
    
    built_in_min = c()
    minsta = strtoi(ALL[[i]][2])
    
    for (ii in 2:(tmpd+1)){
      built_in_min = c(built_in_min, ALL[[i]][ii])
      
      if (ALL[[i]][ii] < minsta) {
        
        minsta = strtoi(ALL[[i]][ii])

      }
    }
    
    cat("Lowest temp for",ALL[[i]][1])
    print(minsta)
    cat("Lowest built-in ---> ", min(built_in_min),"\n")
    
  }
  cat("\n")###########################################
################################# Average temperature ######################################################
  for (i in 1:10){
  
    built_in_avr = c(built_in_max, built_in_min)
    summa = 0
    
    for (ii in 2:(tmpd+1)){
      summa = summa + strtoi(ALL[[i]][ii])
    
    }
    cat("\nAverage temp. for", ALL[[i]][1])
    print (summa/tmpd)
    cat("Average built-in ---> ", mean(as.numeric(built_in_avr)))
  }
}

temppp()
