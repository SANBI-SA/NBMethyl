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

# Normalized file without batch effects. Large file and not in the git rep
# This file will be used as input to ABC.RAP 
write.csv(combat, "../../output/mycn/champ_combat.csv")