R语言处理netCDF数据并绘图
=======================

# 导入库
		library(ncdf4)

# 设置文件路径
		setwd('C:\\shaoqi\\Desktop\\data\\')

# 打开文件，查看文件信息
		nc<-nc_open('')
		print(nc)

# 读取其中的变量
		lat<-ncvar_get(nc=nc, varid = 'latitude')
		lon<-ncvar_get(nc=nc, varid = 'longitude')
		sst<-ncvar_get(nc=nc, varid = 'sst')

############### close file ################
nc_close(nc)

############### plot data ################
filled.contour(x=lat,y=lon,z=sst)
		

