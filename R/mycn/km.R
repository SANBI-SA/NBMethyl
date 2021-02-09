library(survival)
library(ranger)
library(ggplot2)
library(dplyr)
library(ggfortify)
library(survminer)

data <- read.table("../../data-files/mycn/km_os.csv", row.names=1, header=TRUE, sep=",", stringsAsFactors=FALSE)

data$time <- as.numeric(data$time)

data <- mutate(data, status = ifelse((score < -0.545), 0, 1), status = factor(status)) # -0.545, -0.412 
data$status <- as.numeric(data$status)

fit <- survfit(Surv(time, status) ~ MYCN, data = data)

#autoplot(fit, conf.int = F)

ggsurvplot(fit,
           pval = TRUE, conf.int = F,
           linetype = "strata", # Change line type by groups
           surv.median.line = "hv", # Specify median survival
           palette = c("#E7B800", "#2E9FDF"),data = data)
