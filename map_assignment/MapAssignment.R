options(cancensus.api_key='CensusMapper_7163c00c83be5f55f90c44cfb074a0fd')
install.packages('cancensus')
library(cancensus)
toronto <- get_census(dataset='CA16', regions=list(CMA="35535"), vectors=c(), labels="detailed", geo_format='sf', level='CSD')
library(tidyverse)
glimpse(toronto)
library(ggplot2)
ggplot(toronto, aes(geometry=geometry))+geom_sf()
ggplot(toronto, aes(geometry=geometry, fill=Population))+geom_sf()
toronto2 <- get_census(dataset='CA16', regions=list(CMA="35535"), vectors=c("v_CA16_425"), labels="detailed", geo_format='sf', level='CSD')
glimpse(toronto2)
names(toronto2)
toronto2%>%
  rename("Size"=`v_CA16_425: Average household size`)->toronto3
names(toronto3)
ggplot(toronto3, aes(geometry=geometry, fill=Size))+geom_sf()+
  (scale_fill_distiller(palette="PuRd", direction=1, name="Average Household Size"))+
  labs(title="Average Household Size in Toronto (Census Subdivision)", caption="Source: Statistics Canada")

##Great work Katelyn, here are just some suggestions.

## This is neat. Look at all those big households out in the northwest and all the single people in the core!!
ggplot(toronto3, aes(geometry=geometry, fill=Size))+geom_sf()+
  (scale_fill_distiller(palette="PuRd", direction=1, name="Average Household Size"))+
  labs(title="Average Household Size in Toronto (Census Subdivision)", caption="Source: Statistics Canada")+theme_void()


