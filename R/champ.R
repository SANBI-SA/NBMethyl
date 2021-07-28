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

library(ChAMP)

# ----------------------- 
#    Normalisation
# -----------------------
# Imputed file. Large and noot in the git rep.
beta <- read.csv("../../data-files/mycn/mycn_imp.csv", row.names=1)
# drop normal samples
beta <- beta[,14:ncol(beta)]

myNorm <- champ.norm(beta = data.matrix(beta),cores=2)

# -----------------------
#    Quality check
# -----------------------
pd <- read.csv("../../data-files/mycn/pd.csv", row.names = 1)
pd$batch <- as.factor(pd$batch)

champ.SVD(beta = data.matrix(beta), pd=pd)

# -------------------------------
#   Combat (Remove batch effects)
# -------------------------------
combat <- champ.runCombat(beta = data.matrix(beta), pd = pd, batchname = c("batch"))

# -----------------------------------
#   Differential Methylation Analysis
# -----------------------------------
dmp <- champ.DMP(beta=data.matrix(combat), pheno=pd$Sample_Group, compare.group=c("M","N"))

write.csv(dmp, "../output/champ_dmp_2.csv")


