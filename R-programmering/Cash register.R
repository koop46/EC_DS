
Varor = c("kobba","falafel","shawarma")
Pris = c(10, 15, 25)
  
KorgVara = c()
KorgAntal = c()
KorgPris = c()

### Initial menu to elicit input
meny <- function(){
  
  cat("\n",Varor,"\n")
  
  svar1 = readline("\nVad onskas? \n")
  svar1 = as.character(svar1)
  for (i in Varor){
    if (i == svar1){
      
      ind <- which(Varor == svar1)
      cat("\n",svar1,"---> ", Pris[ind], "kr/styck.")
      kalkyl(svar1, ind)
    }
  }
}

#input is used as argument for calc function
kalkyl <- function(vara,prisind) {
  
  cat("\nHur manga", vara, "vill du ha?\n")
  
  svar2 = readline("")
  svar2 = as.integer(svar2)
  kalk = Pris[prisind]*svar2

  #double arrowhead (<<-) is to update global variable
  KorgVara <<- append(KorgVara, vara)
  KorgAntal <<- append(KorgAntal, svar2)
  KorgPris <<- append(KorgPris, Pris[prisind])
  
  cat("\n")
  cat(svar2, "stycken", Varor[prisind],":", kalk,"kr")
  cat("\nVill du lagga till nagot mer?\n")

  while (TRUE){

    svar3 = readline("[y] or [n]")
    if (svar3 == "y"){
      meny()
    }
    else if (svar3 == "n"){
      checkout()
    }
    else {
      print("Valj y eller n")
    }
    break
  }  
}


checkout <- function(){
  
  lkv = length(KorgVara)
  total = 0
  
  cat("\nDin beställning:\n")
  
  for (i in 1:lkv){
    
    cat(KorgAntal[i], KorgVara[i],".........",KorgAntal[i]*KorgPris[i],"kr\n")
    total = total + (KorgAntal[i]*KorgPris[i])
  }
    cat("\nTotalt.........:", total,"kr")

    pay(total)    
}

  
pay <- function(total){
  
  svar4 = readline("\nSumma for betalning ")
  svar4 = as.integer(svar4)
  
  vaxel = (svar4-total)
  
  cat(vaxel,"kr tillbaka i vaxel")
}
  
meny()
