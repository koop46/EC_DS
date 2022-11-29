
Q1 <- c()
yrs <- c()
n <- 1959
avr <- c(0)
twh <- 0.00000002930710701583

################################ Reassemble data frame #########################

for (x in 1:length(UKgas)){ #########sorting data by quartile
  
  if (x%%4==1){
    
    Q1 <- c(Q1, UKgas[x]*1000000*twh)
    
  }
}


for (i in 0:26){ #########create rownames / Y-axis
  
  n <- (n+1)
  yrs <- c(yrs, n)
  
}

df1 <- data.frame(Qt1 = Q1) ######### reassemble
rownames(df1) <- yrs


for (i in 3:length(df1$Qt1)){ ######### calculate mean
  
  x <- (1-df1$Qt1[(i-1)]/df1$Qt1[i])*100
  
  avr <- c(avr, x)
  
}

avr_inc <-round(mean(avr),digits=1) #average increase

sprintf(
  "Mean percent increase ---> %g%s",
  avr_inc,"%")


######################################### Plotting graphs ################################


plot(y = df1$Qt1, main = "TWh of gas consumption", x = yrs, pch = 20,
     xlab = "Years", col = "brown",
     ylab = "TWh")


gas.m <- lm(formula = Qt1 ~ yrs, data = df1)

coef(gas.m)

abline(a = coef(gas.m)[1], 
       b = coef(gas.m)[2],
       lty = 2,
       col = "green")

summary(gas.m)

################################


plot(y = avr, main = "Average increase in gas consumption: Q1", x = yrs[2:27], pch = 20,
     xlab = "Years", col = "brown",
     ylab = "TWh")


gas.avr <- lm(formula = avr ~ yrs[2:27])

coef(gas.avr)

abline(a = coef(gas.avr)[1], 
       b = coef(gas.avr)[2],
       lty = 2,
       col = "green")

summary(gas.avr)

##################### calculating top 25% percentile.

val_below <- length(sort(avr)[1:20])
tot_val <- length(sort(avr))
div <- 100-round(val_below/tot_val*100,digits = 1)

######################

z.score = (avr - mean(avr)/sd(avr)) #Z-score calculation
yrs2 <- yrs[2:27]
plot(x = yrs2, y = z.score, type="o", col="green")

sprintf(
  "68%s of data falls between %g  and %g",
  "%", avr_inc - sd(avr), avr_inc + sd(avr))

sprintf(
  "95%s of data falls between %g  and %g",
  "%", avr_inc - 2 * sd(avr), avr_inc + 2 * sd(avr))

sprintf(
  "99.7%s of data falls between %g  and %g",
  "%", avr_inc - 3 * sd(avr), avr_inc + 3 * sd(avr))

df2 <- data.frame(yrs2,z.score)

df2

######################


sprintf(
  "Coeffient of variation ---> %g%s",
  sd(avr)/mean(avr)*100,"%")


###############################Exporting graphs#################################


png(file = "baba.jpg")

plot(y = avr, main = "Average increase in gas consumption: Q1", x = yrs[2:27], pch = 20,
     xlab = "Years", col = "brown",
     ylab = "TWh")


gas.avr <- lm(formula = avr ~ yrs[2:27])

coef(gas.avr)

abline(a = coef(gas.avr)[1], 
       b = coef(gas.avr)[2],
       lty = 2,
       col = "green")

dev.off()


png(file = "z.score.jpg")

plot(x = yrs2, y = z.score, type="o", col="green")

dev.off()
