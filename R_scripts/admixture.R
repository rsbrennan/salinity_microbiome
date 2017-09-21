library(ggplot2)
library(reshape2)
library(scales)
library(gridExtra)

dat2 <- read.table("~/shm/analysis/admixture/all.2.Q")
dat3 <- read.table("~/shm/analysis/admixture/all.3.Q")
dat4 <- read.table("~/shm/analysis/admixture/all.4.Q")

id <- read.table("~/shm/variants/all.fam", header=FALSE)
labels <- substr(id$V2, 1,2)
site <- substr(id$V2, 1,5)
labs <- data.frame(population = labels, Individual = id$V1, site=site)

dat2 <- cbind(labs, dat2)
dat3 <- cbind(labs, dat3)
dat4 <- cbind(labs, dat4)

all.list <- list(dat2=dat2, dat3=dat3, dat4=dat4)

for (i in 1:3){
	all.list[[i]]$ord <- c("NA")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fd-P1")] <- c("01")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fd-J1")] <- c("02")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-P1")] <- c("03")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-J1")] <- c("04")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-P2")] <- c("05")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-J2")] <- c("06")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-P3")] <- c("07")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-J3")] <- c("08")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-P4")] <- c("09")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-P5")] <- c("10")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-J5")] <- c("11")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-P6")] <- c("12")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-J6")] <- c("13")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fh-J7")] <- c("14")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fm-P6")] <- c("15")
	all.list[[i]]$ord[which(all.list[[i]]$site == "Fm-J7")] <- c("16")
	all.list[[i]] <- all.list[[i]][order(all.list[[i]]$ord),]
	all.list[[i]]$num <- paste(all.list[[i]]$ord, all.list[[i]]$Individual, sep="-")
}

# write txt files of values
write.table(dat2, "~/shm/analysis/admixture/all_k2.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat3, "~/shm/analysis/admixture/all_k3.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat4, "~/shm/analysis/admixture/all_k4.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")

pdf("~/shm/figures/admixture.all.pdf", width=10, height= 7)

par(mfrow = c(3, 1))
par(mar = c(3, 3, 1, 1), oma = c(1, 1, 1, 1))

#k=2
site<-all.list[["dat2"]][,3]
site <- factor(site, levels = c("Fd-P1","Fd-J1","Fh-P1","Fh-J1","Fh-P2","Fh-J2","Fh-P3","Fh-J3","Fh-P4","Fh-P5","Fh-J5","Fh-P6","Fh-J6","Fh-J7","Fm-P6","Fm-J7"))
h<-barplot(t(all.list[["dat2"]][,4:5]),xaxt="n",col=c("blue", "red"),space=0,border=NA,xlab="",ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=2")

site<-all.list[["dat3"]][,3]
site <- factor(site, levels = c("Fd-P1","Fd-J1","Fh-P1","Fh-J1","Fh-P2","Fh-J2","Fh-P3","Fh-J3","Fh-P4","Fh-P5","Fh-J5","Fh-P6","Fh-J6","Fh-J7","Fm-P6","Fm-J7"))
h<-barplot(t(all.list[["dat3"]][,4:6]),xaxt="n",col=c("blue", "red", "purple"),space=0,border=NA,xlab="",ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (as.character(unique(site))),xpd=T)
title(main="K=3")

site<-all.list[["dat4"]][,3]
site <- factor(site, levels = c("Fd-P1","Fd-J1","Fh-P1","Fh-J1","Fh-P2","Fh-J2","Fh-P3","Fh-J3","Fh-P4","Fh-P5","Fh-J5","Fh-P6","Fh-J6","Fh-J7","Fm-P6","Fm-J7"))
h<-barplot(t(all.list[["dat4"]][,4:7]),xaxt="n",col=c("blue", "red", "purple", "green"),space=0,border=NA,xlab="",ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (as.character(unique(site))),xpd=T)
title(main="K=4")

dev.off()



###########
###########
########### fh alone
###########
###########
###########

dat2 <- read.table("~/shm/analysis/admixture/fh.2.Q")
dat3 <- read.table("~/shm/analysis/admixture/fh.3.Q")
dat4 <- read.table("~/shm/analysis/admixture/fh.4.Q")

id <- read.table("~/shm/variants/fh.fam", header=FALSE)
labels <- substr(id$V2, 1,2)
site <- substr(id$V2, 4,5)
river <- substr(id$V2, 4,4)
labs <- data.frame(population = labels, Individual = id$V1, site=site)

dat2 <- cbind(labs, dat2)
dat3 <- cbind(labs, dat3)
dat4 <- cbind(labs, dat4)

colnames(dat2) <- c("population", "individual", "site", "P1", "P2")
colnames(dat3) <- c("population", "individual", "site", "P1", "P2", "P3")

all.list <- list(dat2=dat2, dat3=dat3, dat4=dat4)

for (i in 1:3){
	all.list[[i]]$ord <- c("NA")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P1")] <- c("01")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J1")] <- c("02")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P2")] <- c("03")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J2")] <- c("04")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P3")] <- c("05")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J3")] <- c("06")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P4")] <- c("07")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P5")] <- c("08")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J5")] <- c("09")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P6")] <- c("10")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J6")] <- c("11")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J7")] <- c("12")
	all.list[[i]] <- all.list[[i]][order(all.list[[i]]$ord),]
	all.list[[i]]$num <- paste(all.list[[i]]$ord, all.list[[i]]$Individual, sep="-")
}

#write txt files
write.table(dat2, "~/shm/analysis/admixture/fh.k2.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat3, "~/shm/analysis/admixture/fh.k3.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat4, "~/shm/analysis/admixture/fh.k4.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")

pdf("~/shm/figures/admixture.fh.pdf", width=6.67, height= 4.67)

par(mfrow = c(2, 1))
par(mar = c(3, 3, 1, 1), oma = c(1, 1, 1, 1))

#k=2
site<-all.list[["dat2"]][,3]
site <- factor(site, levels = c("P1", "J1", "P2", "J2", "P3", "J3", "P4", "P5", "J5", "P6", "J6", "J7"))
h<-barplot(t(all.list[["dat2"]][,4:5]),xaxt="n",col=c("blue", "red"),space=0,border=NA,xlab="",
	ylab="admixture proportion", cex.axis=0.66)
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T,cex=.66 )
title(main="K=2")

site<-all.list[["dat3"]][,3]
site <- factor(site, levels = c("P1", "J1", "P2", "J2", "P3", "J3", "P4", "P5", "J5", "P6", "J6", "J7"))
h<-barplot(t(all.list[["dat3"]][,4:6]),xaxt="n",col=c("blue", "red", "purple"),space=0,border=NA,xlab="",
	ylab="admixture proportion", cex.axis=0.66)
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T,cex=.66)
title(main="K=3")

dev.off()





####### ignore below here for now #########################





###########
###########
########### fh potomac
###########
###########
###########

dat2 <- read.table("~/shm/results/fh.potomac.2.Q")
dat3 <- read.table("~/shm/results/fh.potomac.3.Q")
dat4 <- read.table("~/shm/results/fh.potomac.4.Q")

id <- read.table("~/shm/variants/fh.potomac.fam", header=FALSE)
labels <- substr(id$V2, 1,2)
site <- substr(id$V2, 4,5)
river <- substr(id$V2, 4,4)
labs <- data.frame(population = labels, Individual = id$V1, site=site)

dat2 <- cbind(labs, dat2)
dat3 <- cbind(labs, dat3)
dat4 <- cbind(labs, dat4)

colnames(dat2)<- c("species", "Individual", "site", "P1", "P2")
colnames(dat3)<- c("species", "Individual", "site", "P1", "P2", "P3")
colnames(dat4)<- c("species", "Individual", "site", "P1", "P2", "P4")

all.list <- list(dat2=dat2, dat3=dat3, dat4=dat4)

for (i in 1:3){
	all.list[[i]]$ord <- c("NA")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P1")] <- c("01")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P2")] <- c("02")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P3")] <- c("03")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P4")] <- c("04")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P5")] <- c("05")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P6")] <- c("06")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J7")] <- c("07")
	all.list[[i]] <- all.list[[i]][order(all.list[[i]]$ord),]
	all.list[[i]]$num <- paste(all.list[[i]]$ord, all.list[[i]]$Individual, sep="-")
}

#write txt files
write.table(dat2, "~/shm/results/fh.potomac_k2.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat3, "~/shm/results/fh.potomac_k3.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat4, "~/shm/results/fh.potomac_k4.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")

png("~/shm/figures/admixture.fh.potomac.png", width=900, height= 600, units="px")

par(mfrow = c(2, 1))
par(mar = c(3, 3, 1, 1), oma = c(1, 1, 1, 1))


#k=2
site<-all.list[["dat2"]][,3]
site <- factor(site, levels = c("P1", "P2", "P3", "P4", "P5", "P6", "J7"))
h<-barplot(t(all.list[["dat2"]][,4:5]),xaxt="n",col=c("blue", "red"),space=0,border=NA,xlab="",ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=2")

pop<-all.list[["dat3"]][,3]
site <- factor(site, levels = c("P1", "P2", "P3", "P4", "P5", "P6", "J7"))
h<-barplot(t(all.list[["dat3"]][,4:6]),xaxt="n",col=c("blue", "red", "purple"),space=0,border=NA,xlab="",ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=3")

dev.off()


###########
###########
########### fh james
###########
###########
###########

dat2 <- read.table("~/shm/results/fh.james.2.Q")
dat3 <- read.table("~/shm/results/fh.james.3.Q")
dat4 <- read.table("~/shm/results/fh.james.4.Q")

id <- read.table("~/shm/variants/fh.james.fam", header=FALSE)
labels <- substr(id$V2, 1,2)
site <- substr(id$V2, 4,5)
river <- substr(id$V2, 4,4)
labs <- data.frame(population = labels, Individual = id$V1, site=site)

dat2 <- cbind(labs, dat2)
dat3 <- cbind(labs, dat3)
dat4 <- cbind(labs, dat4)

colnames(dat2)<- c("species", "Individual", "site", "P1", "P2")
colnames(dat3)<- c("species", "Individual", "site", "P1", "P2", "P3")
colnames(dat4)<- c("species", "Individual", "site", "P1", "P2", "P4")

all.list <- list(dat2=dat2, dat3=dat3, dat4=dat4)

for (i in 1:3){
	all.list[[i]]$ord <- c("NA")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J1")] <- c("01")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J2")] <- c("02")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J3")] <- c("03")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J5")] <- c("04")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J6")] <- c("05")
	all.list[[i]]$ord[which(all.list[[i]]$site == "J7")] <- c("06")
	all.list[[i]] <- all.list[[i]][order(all.list[[i]]$ord),]
	all.list[[i]]$num <- paste(all.list[[i]]$ord, all.list[[i]]$Individual, sep="-")
}

#write txt files
write.table(dat2, "~/shm/results/fh.james_k2.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat3, "~/shm/results/fh.james_k3.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat4, "~/shm/results/fh.james_k4.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")

png("~/shm/figures/admixture.fh.james.png", width=900, height= 600, units="px")

par(mfrow = c(2, 1))
par(mar = c(3, 3, 1, 1), oma = c(1, 1, 1, 1))


#k=2
site<-all.list[["dat2"]][,3]
site <- factor(site, levels = c("J1", "J2", "J3", "J5", "J6", "J7"))
h<-barplot(t(all.list[["dat2"]][,4:5]),xaxt="n",col=c("blue", "red"),space=0,border=NA,xlab="",ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=2")

pop<-all.list[["dat3"]][,3]
site <- factor(site, levels = c("J1", "J2", "J3", "J5", "J6", "J7"))
h<-barplot(t(all.list[["dat3"]][,4:6]),xaxt="n",col=c("blue", "red", "purple"),space=0,border=NA,xlab="",ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=3")

dev.off()


###########
###########
########### fh potomac, admixed fhet (from f dia) and J7 removed
###########
###########
###########

dat2 <- read.table("~/shm/results/fh.potomac.admix_J7_remove.2.Q")
dat3 <- read.table("~/shm/results/fh.potomac.admix_J7_remove.3.Q")
dat4 <- read.table("~/shm/results/fh.potomac.admix_J7_remove.4.Q")

id <- read.table("~/shm/variants/fh.potomac.admix_J7_remove.fam", header=FALSE)
labels <- substr(id$V2, 1,2)
site <- substr(id$V2, 4,5)
river <- substr(id$V2, 4,4)
labs <- data.frame(population = labels, Individual = id$V1, site=site)

dat2 <- cbind(labs, dat2)
dat3 <- cbind(labs, dat3)
dat4 <- cbind(labs, dat4)

colnames(dat2)<- c("species", "Individual", "site", "P1", "P2")
colnames(dat3)<- c("species", "Individual", "site", "P1", "P2", "P3")
colnames(dat4)<- c("species", "Individual", "site", "P1", "P2", "P4")

all.list <- list(dat2=dat2, dat3=dat3, dat4=dat4)

for (i in 1:3){
	all.list[[i]]$ord <- c("NA")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P1")] <- c("01")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P2")] <- c("02")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P3")] <- c("03")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P4")] <- c("04")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P5")] <- c("05")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P6")] <- c("06")
	all.list[[i]] <- all.list[[i]][order(all.list[[i]]$ord),]
	all.list[[i]]$num <- paste(all.list[[i]]$ord, all.list[[i]]$Individual, sep="-")
}
#write txt files
write.table(dat2, "~/shm/results/fh.potomac.admix_J7_remove_k2.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat3, "~/shm/results/fh.potomac.admix_J7_remove_k3.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat4, "~/shm/results/fh.potomac.admix_J7_remove_k4.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")

png("~/shm/figures/admixture.fh.potomac.admix_J7_remove.png", width=900, height= 600, units="px")

par(mfrow = c(2, 1))
par(mar = c(3, 3, 1, 1), oma = c(1, 1, 1, 1))


#k=2
site<-all.list[["dat2"]][,3]
site <- factor(site, levels = c("P1", "P2", "P3", "P4", "P5", "P6", "J7"))
h<-barplot(t(all.list[["dat2"]][,4:5]),xaxt="n",col=c("blue", "red"),space=0,border=NA,xlab="",
	ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=2")

pop<-all.list[["dat3"]][,3]
site <- factor(site, levels = c("P1", "P2", "P3", "P4", "P5", "P6", "J7"))
h<-barplot(t(all.list[["dat3"]][,4:6]),xaxt="n",col=c("blue", "red", "purple"),space=0,border=NA,xlab="",
	ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=3")

dev.off()


###########
###########
########### fh potomac, admixed fhet (from f dia) and J7 kept
###########
###########
###########

dat2 <- read.table("~/shm/results/fh.potomac.admix_remove.2.Q")
dat3 <- read.table("~/shm/results/fh.potomac.admix_remove.3.Q")
dat4 <- read.table("~/shm/results/fh.potomac.admix_remove.4.Q")

id <- read.table("~/shm/variants/fh.potomac.admix_remove.fam", header=FALSE)
labels <- substr(id$V2, 1,2)
site <- substr(id$V2, 4,5)
river <- substr(id$V2, 4,4)
labs <- data.frame(population = labels, Individual = id$V1, site=site)

dat2 <- cbind(labs, dat2)
dat3 <- cbind(labs, dat3)
dat4 <- cbind(labs, dat4)

colnames(dat2)<- c("species", "Individual", "site", "P1", "P2")
colnames(dat3)<- c("species", "Individual", "site", "P1", "P2", "P3")
colnames(dat4)<- c("species", "Individual", "site", "P1", "P2", "P4")

all.list <- list(dat2=dat2, dat3=dat3, dat4=dat4)

for (i in 1:3){
	all.list[[i]]$ord <- c("NA")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P1")] <- c("01")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P2")] <- c("02")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P3")] <- c("03")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P4")] <- c("04")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P5")] <- c("05")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P6")] <- c("06")
	all.list[[i]]$ord[which(all.list[[i]]$site == "P7")] <- c("07")
	all.list[[i]] <- all.list[[i]][order(all.list[[i]]$ord),]
	all.list[[i]]$num <- paste(all.list[[i]]$ord, all.list[[i]]$Individual, sep="-")
}
#write txt files
write.table(dat2, "~/shm/results/fh.potomac.admix_remove_k2.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat3, "~/shm/results/fh.potomac.admix_remove_k3.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
write.table(dat4, "~/shm/results/fh.potomac.admix_remove_k4.txt", quote=FALSE, col.names=TRUE,row.names=FALSE, sep="\t")

png("~/shm/figures/admixture.fh.potomac.admix_remove.png", width=900, height= 600, units="px")

par(mfrow = c(2, 1))
par(mar = c(3, 3, 1, 1), oma = c(1, 1, 1, 1))


#k=2
site<-all.list[["dat2"]][,3]
site <- factor(site, levels = c("P1", "P2", "P3", "P4", "P5", "P6", "J7"))
h<-barplot(t(all.list[["dat2"]][,4:5]),xaxt="n",col=c("blue", "red"),space=0,border=NA,xlab="",
	ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=2")

pop<-all.list[["dat3"]][,3]
site <- factor(site, levels = c("P1", "P2", "P3", "P4", "P5", "P6", "J7"))
h<-barplot(t(all.list[["dat3"]][,4:6]),xaxt="n",col=c("blue", "red", "purple"),space=0,border=NA,xlab="",
	ylab="admixture proportion")
text(x= as.vector(tapply(1:length(site),site,mean)),y= -0.05,labels= (unique(site)),xpd=T)
title(main="K=3")

dev.off()
