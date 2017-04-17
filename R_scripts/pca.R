dat <- read.table("~/shm/results/all.thinned.eigenvec", header=TRUE)
#var <- read.table("~/admixture_mapping/results/pca.subsamp.eigenval", header=FALSE)
labels <- substr(dat$IID, 1,5)
species <- substr(dat$IID, 1,2)
dat <- cbind (labels, dat)
dat <- cbind(species, dat)

fd <- which(dat$species == "Fd")
fh <- which(dat$species == "Fh")
fm <- which(dat$species == "Fm")

col.plot <- c("blue", "red","green")
png("~/shm/results/pca_all.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC1, y=dat$PC2, col=col.plot[dat$species], pch=NA, xlab="PC1- 35%", ylab="PC2- 19%", cex=1, main="All pops")

text(dat$PC1[fh],dat$PC2[fh],label=dat$labels[fh],col='blue')
text(dat$PC1[fd],dat$PC2[fd],label=dat$labels[fd],col='red')
text(dat$PC1[fm],dat$PC2[fm],label=dat$labels[fm],col='green')
legend(x="topright", legend = levels(dat$species), col=c("red", "blue", "green"), pch=19)
dev.off()


######
###### fd and fh only

dat <- read.table("~/shm/results/fh_fd.thinned.eigenvec", header=TRUE)
#var <- read.table("~/admixture_mapping/results/pca.subsamp.eigenval", header=FALSE)
labels <- substr(dat$IID, 1,5)
species <- substr(dat$IID, 1,2)
dat <- cbind (labels, dat)
dat <- cbind(species, dat)

fd <- which(dat$species == "Fd")
fh <- which(dat$species == "Fh")

col.plot <- c("blue", "red")
png("~/shm/results/pca_fh_fd.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC1, y=dat$PC2, col=col.plot[dat$species], pch=NA, xlab="PC1- 25%", ylab="PC2- 5%", cex=1, main="F. het and F. dia")

text(dat$PC1[fh],dat$PC2[fh],label=dat$labels[fh],col='blue')
text(dat$PC1[fd],dat$PC2[fd],label=dat$labels[fd],col='red')
legend(x="bottomleft", legend = levels(dat$species), col=c("red", "blue"), pch=19)
dev.off()

######
###### fh only

dat <- read.table("~/shm/results/fh.thinned.eigenvec", header=TRUE)
#var <- read.table("~/admixture_mapping/results/pca.subsamp.eigenval", header=FALSE)
labels <- substr(dat$IID, 1,5)
species <- substr(dat$IID, 1,2)
river <- substring(labels, 4,4)
location <- substring(labels, 5,5)
dat <- cbind (labels, dat)
dat <- cbind(species, dat)
dat <- cbind(river, dat)
dat <- cbind(location, dat)


col.plot <- c("blue", "red")
png("~/shm/results/pca_fh.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC1, y=dat$PC2, col=col.plot[dat$river], pch=NA, xlab="PC1- 5%", ylab="PC2- 4%", cex=0.2, main="F. het")

text(dat$PC1,dat$PC2,label=dat$labels,col=col.plot[dat$river], cex=0.6)
legend(x="bottomright", legend = levels(dat$river), col=c("red", "blue"), pch=19)
dev.off()

#trying to differentiate between samp locations
col.plot <- c("blue", "red", "green", "orange", "purple", "black", "grey" )
shape <- c(19, 17)
png("~/shm/results/pca_fh_rivers.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC1, y=dat$PC2, col=col.plot[dat$location], pch=shape[dat$river], xlab="PC1- 5%", ylab="PC2- 4%", cex=1.3, main="F. het")

#text(dat$PC1,dat$PC2,label=dat$labels,col=col.plot[dat$river])
legend(x="topright", legend = levels(dat$river), col=c("black"), pch=shape[dat$river])
legend(x="bottomright", legend = levels(dat$location), col=col.plot, pch=18, cex=1.4)

dev.off()
