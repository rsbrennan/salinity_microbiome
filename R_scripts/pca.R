
dat <- read.table("~/shm/results/pcs.all.txt", header=FALSE)
var <- read.table("~/shm/results/pve.all.txt")
labels <- read.table("~/shm/variants/all.fam", header=FALSE)
dat <- cbind (labels$V1, dat)
dat <- cbind (substr(labels$V1, 1,2), dat)
colnames(dat) <- c("pop", "indiv", "PC1", "PC2", "PC3", "PC4","PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

fd <- which(dat$pop == "Fd")
fh <- which(dat$pop == "Fh")
fm <- which(dat$pop == "Fm")


col.plot <- c("blue", "red","green")
png("~/shm/figures/pca_all_PC1vsPC2.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC1, y=dat$PC2, 
	col=col.plot[dat$pop], 
	xlab=paste("PC-1: ", round((var$V1[1]*100), 1), "%", sep=""), 
	ylab=paste("PC-2: ", round((var$V1[2]*100), 1), "%", sep=""),
	main="PCA: PC1 vs PC2 for all indivs", 
	cex=1.6,
	pch=19)
legend(x="bottomright", legend = levels(dat$pop), col=col.plot, pch=19)
dev.off()

png("~/shm/figures/pca_all_PC2vsPC3.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC2, y=dat$PC3, 
	col=col.plot[dat$pop], 
	xlab=paste("PC-2: ", round((var$V1[2]*100), 1), "%", sep=""), 
	ylab=paste("PC-3: ", round((var$V1[3]*100), 1), "%", sep=""),
	main="PCA: PC2 vs PC3 for all indivs" ,
	cex=1.6,
	pch=19)
legend(x="bottomright", legend = levels(dat$pop), col=col.plot, pch=19)
dev.off()


######
###### fd and fh only
######

dat <- read.table("~/shm/results/pcs.fh_fd.txt", header=FALSE)
var <- read.table("~/shm/results/pve.fh_fd.txt")
labels <- read.table("~/shm/variants/fh_fd.fam", header=FALSE)
dat <- cbind (labels$V1, dat)
dat <- cbind (substr(labels$V1, 1,2), dat)
dat <- cbind (substr(labels$V1, 1,5), dat)
colnames(dat) <- c("site", "pop", "indiv", "PC1", "PC2", "PC3", "PC4","PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

fd <- which(dat$pop == "Fd")
fh <- which(dat$pop == "Fh")

col.plot <- c("blue", "red")
png("~/shm/figures/pca_fh_fd_PC1vsPC2.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC1, y=dat$PC2, 
	xlab=paste("PC-1: ", round((var$V1[1]*100), 1), "%", sep=""), 
	ylab=paste("PC-2: ", round((var$V1[2]*100), 1), "%", sep=""),
	main="PCA: PC1 vs PC2  F. het and F. dia only", 
	cex=1.6,
	pch=NA)
text(dat$PC1[fh],dat$PC2[fh],label=dat$site[fh],col='blue')
text(dat$PC1[fd],dat$PC2[fd],label=dat$site[fd],col='red')
#legend(x="bottomright", legend = levels(dat$site), col=col.plot, pch=19)
dev.off()

png("~/shm/figures/pca_fh_fd_PC2vsPC3.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC2, y=dat$PC3, 
	xlab=paste("PC-2: ", round((var$V1[2]*100), 1), "%", sep=""), 
	ylab=paste("PC-3: ", round((var$V1[3]*100), 1), "%", sep=""),
	main="PCA: PC2 vs PC3 F. het and F. dia only" ,
	cex=1.6,
	pch=NA)
text(dat$PC2[fh],dat$PC3[fh],label=dat$site[fh],col='blue')
text(dat$PC2[fd],dat$PC3[fd],label=dat$site[fd],col='red')
#legend(x="bottomright", legend = levels(dat$site), col=col.plot, pch=19)
dev.off()


######
######  fh only
######

dat <- read.table("~/shm/results/pcs.fh.txt", header=FALSE)
var <- read.table("~/shm/results/pve.fh.txt")
labels <- read.table("~/shm/variants/fh.fam", header=FALSE)
dat <- cbind (labels$V1, dat)
dat <- cbind (substr(labels$V1, 1,2), dat)
dat <- cbind (substr(labels$V1, 1,5), dat)
dat <- cbind (substr(labels$V1, 4,4), dat)
colnames(dat) <- c("river","site", "pop", "indiv", "PC1", "PC2", "PC3", "PC4","PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

james <- which(dat$river == "J")
potomac <- which(dat$river == "P")

col.plot <- c("blue", "red")
png("~/shm/figures/pca_fh_PC1vsPC2.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC1, y=dat$PC2, 
	xlab=paste("PC-1: ", round((var$V1[1]*100), 1), "%", sep=""), 
	ylab=paste("PC-2: ", round((var$V1[2]*100), 1), "%", sep=""),
	main="PCA: PC1 vs PC2  F. het only", 
	cex=1.6,
	pch=NA)
text(dat$PC1[james],dat$PC2[james],label=dat$site[james],col='blue')
text(dat$PC1[potomac],dat$PC2[potomac],label=dat$site[potomac],col='red')
legend(x="bottomleft", legend = c("James", "Potomac"), col=col.plot, pch=19)
dev.off()

png("~/shm/figures/pca_fh_PC2vsPC3.png", h=1000, w=1000, pointsize=20)
plot(x=dat$PC2, y=dat$PC3, 
	xlab=paste("PC-2: ", round((var$V1[2]*100), 1), "%", sep=""), 
	ylab=paste("PC-3: ", round((var$V1[3]*100), 1), "%", sep=""),
	main="PCA: PC2 vs PC3 F. het only" ,
	cex=1.6,
	pch=NA)
text(dat$PC2[james],dat$PC3[james],label=dat$site[james],col='blue')
text(dat$PC2[potomac],dat$PC3[potomac],label=dat$site[potomac],col='red')
legend(x="bottomright", legend = c("James", "Potomac"), col=col.plot, pch=19)
dev.off()
