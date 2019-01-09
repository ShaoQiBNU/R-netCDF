R语言处理netCDF数据并绘图
=======================

# 导入包

```R
library(ncdf4)
library(maps)
library(mapdata)
library(sp)
library(ggplot2)
library(raster)
library(rgdal) 
```


# 设置路径

```R
setwd("C:/Users/shaoqi/Desktop/data/")
```

# 读取nc数据
```R
nc<-nc_open('HadISST_sst.nc')
print(nc)
```

# 获取变量及相关信息
```R
time<-ncvar_get(nc=nc, varid = 'time')
dim(time)

lat<-ncvar_get(nc=nc, varid = 'latitude')
dim(lat)

lon<-ncvar_get(nc=nc, varid = 'longitude')
dim(lon)

sst<-ncvar_get(nc=nc, varid = 'sst')
dim(sst)

```

## 获取变量属性
```R
fillvalue <- ncatt_get(nc, "sst", "missing_value")

sst[sst == fillvalue] <- NA

sst[sst == -1000] <- NAst)

```

# 关闭文件
```R
nc_close(nc)

```

# 绘图
```R
png("sst.png",width = 12*500,height = 7*500,res = 500)

```

## 设置colorbar
```R
colors <- c('blue', "white",'red') 
RB <- colorRampPalette(colors = colors)
```

## 设置colorbar显示范围及间隔
```R
levels <- seq(-5, 30, 2) 
``` 

## 调整数据顺序，将数据上下颠倒
```R
temp=sst[,,1]
sst1=temp
sst1[,180:91]=temp[,1:90]
sst1[,90:1]=temp[,91:180]
```

## 画图
		filled.contour(x = lon, y = rev(lat), z = sst1,levels= levels,nlevels = 20,
               		color.palette = RB,   
