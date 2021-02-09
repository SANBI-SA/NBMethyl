library(Biobase)
library(GEOquery)

require(glmnet)
require(survival)

data=read.table("../../data-files/mycn/glmnet_os.csv", row.names=1, header=TRUE, sep=",", stringsAsFactors=FALSE)

data$time <- as.numeric(data$time)
data$status <- as.numeric(data$status)

# Leave-one-out cross-validation
x = data.matrix(data[,1:(ncol(data)-2)])
y = Surv(data$time, data$status)
cvfit = cv.glmnet(x = x, y = y, family = "cox", nfolds = nrow(data), grouped = T)

cvfit

plot(cvfit)

# fit. Change the value of nlambda with the value in cvfit
fit <- glmnet(x = x, y = y, family = 'cox', nlambda = 3, lambda = cvfit$lambda.1se)

coefs <- coef(fit, s = cvfit$lambda.1se)
df <- data.frame(name = coefs@Dimnames[[1]][coefs@i + 1], coefficient = coefs@x)
df
