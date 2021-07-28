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

library(survival)
library(ranger)
library(ggplot2)
library(dplyr)
library(ggfortify)
library(survminer)

data <- read.table("../data-files/km_os.csv", row.names=1, header=TRUE, sep=",", stringsAsFactors=FALSE)

data$time <- as.numeric(data$time)

data <- mutate(data, status = ifelse((score < -0.88), 0, 1), status = factor(status)) # -0.88, -0.44 
data$status <- as.numeric(data$status)

fit <- survfit(Surv(time, status) ~ MYCN, data = data)

#autoplot(fit, conf.int = F)

ggsurvplot(fit,
           pval = TRUE, conf.int = F,
           linetype = "strata", # Change line type by groups
           surv.median.line = "hv", # Specify median survival
           palette = c("#E7B800", "#2E9FDF"),data = data)
