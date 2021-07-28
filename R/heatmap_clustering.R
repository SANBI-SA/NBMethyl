# Copyright (C) 2020  Hocine Bendou <hocine@sanbi.ac.za>
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


#Heatmap plot
library(gplots)
data <- as.matrix(read.csv("../data-files/heatmap.csv", row.names=1))
colours <- rep(c("black", "pink"), c(45,81))
tiff(file = "../../output/images/MYCN-amp-heat.tiff", width = 2200, height = 1280, res=300)
heatmap.2(data, trace = "none", dendrogram = "col", col=heat.colors(14),
          cexRow = 0.7,ColSideColors=colours,key=F,labCol = F)
dev.off()

#Clustering dendrogram
library(factoextra)
data <- as.matrix(read.csv("../data-files/clustering.csv", row.names=1))
res.hk <- hkmeans(data, 2)
tiff(file = "../../output/images/AvNA-Cluster.tiff", width = 4000, height = 3000, res=300)
hkmeans_tree(res.hk, cex=0.6, main="")
dev.off()
