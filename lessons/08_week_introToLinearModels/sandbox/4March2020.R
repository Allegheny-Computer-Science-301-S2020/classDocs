rm(list = ls())
height <- c(176, 154, 138, 196, 132, 176, 181, 169, 150, 175)
bodymass <- c(82, 49, 53, 112, 47, 69, 77, 71, 62, 78)
length(height) 
length(bodymass)
plot(bodymass, height)
# is there a correlation?
cor(height, bodymass) # yes!

hb <- lm(height ~ bodymass) # indep ~ dep 
summary(hb)
hb_noIntercept <- lm(height ~ bodymass - 1) # omitting intercept
summary(hb_noIntercept)

plot(bodymass, height)
abline(hb, col = "red")
abline(hb_noIntercept, col = "blue")

rm(list = ls())
Ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
Trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(Ctl, Trt)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept
summary(lm.D9)

qqplot(x = longley$GNP, y = longley$Year)
# Not so good
qqplot(x = longley$GNP.deflator, y =
         longley$Employed)
