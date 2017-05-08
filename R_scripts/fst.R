library(qqman)
#devtools::install_github("taiyun/corrplot")
library(corrplot)

setwd("~/shm/analysis/fst")
filelist = list.files(pattern = "*.weir.fst")

for (i in 1:length(filelist)){
	first <- substring(filelist[i], 1, 5)
	second <- substring(filelist[i], 10, 14)
	if (first == second){
		filelist[i] <- NA
	}
	else{}
}

filelist<- filelist[!is.na(filelist)]

#assuming tab separated values with a header     
data_list = lapply(filelist, read.table, header=TRUE)

names(data_list)<-filelist
colnames <- c("CHR", "BP", "fst")
data_list <- lapply(data_list, setNames, colnames)

#remove chr from chromosome col
for (i in 1:length(data_list)){
	data_list[[i]]$CHR <- ((gsub("chr", "",data_list[[i]]$CHR)))
}
#assign negative fst values 0
for (i in 1:length(data_list)){
	data_list[[i]]$fst.1 <- data_list[[i]]$fst
	data_list[[i]]$fst.1[which(data_list[[i]]$fst.1 < 0)] <- c(0)
}

#calculate mean fst, fst.1
fst <- sapply(data_list, function(x) mean(x$fst, na.rm=TRUE))
fst.1 <- sapply(data_list, function(x) mean(x$fst.1, na.rm=TRUE))
#need to make matrix of fst values for corrplot
names(fst.1) <- gsub(".weir.fst", "", names(fst.1))
name.1 <- unique(gsub("....._vs_", "",names(fst.1)))
name.2 <- unique(gsub("_vs_.....", "",names(fst.1)))
name <- unique(c(name.1, name.2))
values <- as.data.frame(matrix(nrow=length(name), ncol=length(name)))
rownames(values) <- name
colnames(values) <- name
for (i in names(fst.1)){
	pop1 <- substr(i, 1, 5)
	pop2 <- substr(i, 10, 15)
	col <- which( colnames(values) == pop1 )
	row <- which( rownames(values) == pop2 )
	values[row,col]<- fst.1[i]
	col <- which( colnames(values) == pop2 )
	row <- which( rownames(values) == pop1 )
	values[row,col]<- fst.1[i]
}
values[is.na(values)] <- 0
values <- sapply(values, round, 3)
rownames(values) <- name
#values.2 <- values[,c("PP", "AF", "PL", "GA", "HP","BC", "PC", "TR")]
#values.2 <- values.2[c("PP", "AF", "PL", "GA", "HP","BC", "PC", "TR"),]

png("~/shm/figures/fst.all.png", h=1000, w=1000, pointsize=20)
corrplot(values, method="color", type="upper",cl.lim=c(0,max(values)),
	col=colorRampPalette(c("red","white","blue"))(200),
	is.corr=FALSE, addCoef.col="black",
	tl.col="black", cl.pos ="n",
	diag=FALSE, tl.cex = 1.5,tl.srt=45,
	number.digits = 3)
dev.off()

write.table(values, "~/shm/results/fst.all.txt", quote=FALSE)

#Subset potomac only

name.1 <- name[!grepl("Fh-J[0-9]", name, perl=TRUE)]
values <- as.data.frame(matrix(nrow=length(name.1), ncol=length(name.1)))
rownames(values) <- name.1
colnames(values) <- name.1
for (i in names(fst.1)){
	pop1 <- substr(i, 1, 5)
	pop2 <- substr(i, 10, 15)
	col <- which( colnames(values) == pop1 )
	row <- which( rownames(values) == pop2 )
	values[row,col]<- fst.1[i]
	col <- which( colnames(values) == pop2 )
	row <- which( rownames(values) == pop1 )
	values[row,col]<- fst.1[i]
}
values[is.na(values)] <- 0
values <- sapply(values, round, 3)
rownames(values) <- name.1

png("~/shm/figures/fst.potomac.png", h=1000, w=1000, pointsize=20)
corrplot(values, method="color", type="upper",cl.lim=c(0,max(values)),
	col=colorRampPalette(c("red","white","blue"))(200),
	is.corr=FALSE, addCoef.col="black",
	tl.col="black", cl.pos ="n",
	diag=FALSE, tl.cex = 1.5,tl.srt=45,
	number.digits = 3)
dev.off()

#Subset potomac fhet only

name.1 <- name[grepl("Fh-P[0-9]", name, perl=TRUE)]
values <- as.data.frame(matrix(nrow=length(name.1), ncol=length(name.1)))
rownames(values) <- name.1
colnames(values) <- name.1
for (i in names(fst.1)){
	pop1 <- substr(i, 1, 5)
	pop2 <- substr(i, 10, 15)
	col <- which( colnames(values) == pop1 )
	row <- which( rownames(values) == pop2 )
	values[row,col]<- fst.1[i]
	col <- which( colnames(values) == pop2 )
	row <- which( rownames(values) == pop1 )
	values[row,col]<- fst.1[i]
}
values[is.na(values)] <- 0
values <- sapply(values, round, 3)
rownames(values) <- name.1

png("~/shm/figures/fst.potomac_fhet.png", h=1000, w=1000, pointsize=20)
corrplot(values, method="color", type="upper",cl.lim=c(0,max(values)),
	col=colorRampPalette(c("red","white","blue"))(200),
	is.corr=FALSE, addCoef.col="black",
	tl.col="black", cl.pos ="n",
	diag=FALSE, tl.cex = 1.5,tl.srt=45,
	number.digits = 3)
dev.off()


#Subset james only

name.1 <- name[!grepl("Fh-P[0-9]", name, perl=TRUE)]
values <- as.data.frame(matrix(nrow=length(name.1), ncol=length(name.1)))
rownames(values) <- name.1
colnames(values) <- name.1
for (i in names(fst.1)){
	pop1 <- substr(i, 1, 5)
	pop2 <- substr(i, 10, 15)
	col <- which( colnames(values) == pop1 )
	row <- which( rownames(values) == pop2 )
	values[row,col]<- fst.1[i]
	col <- which( colnames(values) == pop2 )
	row <- which( rownames(values) == pop1 )
	values[row,col]<- fst.1[i]
}
values[is.na(values)] <- 0
values <- sapply(values, round, 3)
rownames(values) <- name.1

png("~/shm/figures/fst.james.png", h=1000, w=1000, pointsize=20)
corrplot(values, method="color", type="upper",cl.lim=c(0,max(values)),
	col=colorRampPalette(c("red","white","blue"))(200),
	is.corr=FALSE, addCoef.col="black",
	tl.col="black", cl.pos ="n",
	diag=FALSE, tl.cex = 1.5,tl.srt=45,
	number.digits = 3)
dev.off()

#Subset james f het only

name.1 <- name[grepl("Fh-J[0-9]", name, perl=TRUE)]
values <- as.data.frame(matrix(nrow=length(name.1), ncol=length(name.1)))
rownames(values) <- name.1
colnames(values) <- name.1
for (i in names(fst.1)){
	pop1 <- substr(i, 1, 5)
	pop2 <- substr(i, 10, 15)
	col <- which( colnames(values) == pop1 )
	row <- which( rownames(values) == pop2 )
	values[row,col]<- fst.1[i]
	col <- which( colnames(values) == pop2 )
	row <- which( rownames(values) == pop1 )
	values[row,col]<- fst.1[i]
}
values[is.na(values)] <- 0
values <- sapply(values, round, 3)
rownames(values) <- name.1

png("~/shm/figures/fst.james_fhet.png", h=1000, w=1000, pointsize=20)
corrplot(values, method="color", type="upper",cl.lim=c(0,max(values)),
	col=colorRampPalette(c("red","white","blue"))(200),
	is.corr=FALSE, addCoef.col="black",
	tl.col="black", cl.pos ="n",
	diag=FALSE, tl.cex = 1.5,tl.srt=45,
	number.digits = 3)
dev.off()

