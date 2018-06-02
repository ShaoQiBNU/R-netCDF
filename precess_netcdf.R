## @author: ShaoQi(BNU 17GIS Advisor: Li Jing; NUIST 13RS Advisor: Xu YongMing) ##

############### load packages ################
library(ncdf4)
library(maps)
library(mapdata)
library(sp)
library(ggplot2)
library(raster)
library(rgdal) 

############### set path ################
setwd("C:/Users/shaoqi/Desktop/data/")

############### read netCDF data and print info ################
nc<-nc_open('HadISST_sst.nc')
print(nc)

############### get variables and dimension ################
time<-ncvar_get(nc=nc, varid = 'time')
dim(time)

lat<-ncvar_get(nc=nc, varid = 'latitude')
dim(lat)

lon<-ncvar_get(nc=nc, varid = 'longitude')
dim(lon)

sst<-ncvar_get(nc=nc, varid = 'sst')
dim(sst)

############### get variable attributes ################
fillvalue <- ncatt_get(nc, "sst", "missing_value")

sst[sst == fillvalue] <- NA

sst[sst == -1000] <- NA

############### close file ################
nc_close(nc)

############### plot data ################
png("sst.png",width = 12*500,height = 7*500,res = 500)

############### set color:red-white-blue ################
colors <- c('blue', "white",'red')  

RB <- colorRampPalette(colors = colors)  

############### set color levels ################
levels <- seq(-5, 30, 2)  

############### exchange data:ÉÏÏÂµßµ¹ ################
temp=sst[,,1]
sst1=temp
sst1[,180:91]=temp[,1:90]
sst1[,90:1]=temp[,91:180]

############### fill data ################
filled.contour(x = lon, y = rev(lat), z = sst1,levels= levels,nlevels = 20,
               color.palette = RB,   
               las = 1,  
               plot.title = title(main ="SST", cex.main = 2),  
               plot.axes = list(axis(1,seq(-150, 150, by = 30), 
                                     c('150¡ãW','120¡ãW','90¡ãW','60¡ãW','30¡ãW','0¡ã',
                                       '30¡ãE','60¡ãE','90¡ãE','120¡ãE','150¡ãE')),  
                                axis(2,seq(-75, 75, by = 15), c('75¡ãS','60¡ãS','45¡ãS','30¡ãS','15¡ãS','0¡ã',
                                                                '15¡ãN','30¡ãN','45¡ãS','60¡ãN','75¡ãN'))),  
               key.title = title(main ='degC')) 

dev.off()
