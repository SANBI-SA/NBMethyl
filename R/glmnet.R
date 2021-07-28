# Copyright (C) 2021  Hocine Bendou <hocine@sanbi.ac.za>
#                     Abdulazeez Giwa <3901476@myuwc.ac.za>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>

library(Biobase)
library(GEOquery)
require(glmnet)
require(survival)

data=read.table("../../data-files/glmnet_os.csv", row.names=1, header=TRUE, sep=",", stringsAsFactors=FALSE)

data$time <- as.numeric(data$time)
data$status <- as.numeric(data$status)

# Leave-one-out cross-validation
x = data.matrix(data[,1:(ncol(data)-2)])
y = Surv(data$time, data$status)
cvfit = cv.glmnet(x = x, y = y, family = "cox", nfolds = nrow(data), grouped = T)

cvfit

plot(cvfit)

# fit. Change the value of nlambda with the value in cvfit
fit <- glmnet(x = x, y = y, family = 'cox', nlambda = 8, lambda = cvfit$lambda.1se)

coefs <- coef(fit, s = cvfit$lambda.1se)
df <- data.frame(name = coefs@Dimnames[[1]][coefs@i + 1], coefficient = coefs@x)
df
