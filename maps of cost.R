install.packages("dplyr")
install.packages("maps")
install.packages("sp")


library(ggplot2)
library(dplyr)
library(maps)
library(sp)
#libraries loaded into R

#Now calling up the map for my projection
us <- map_data("state")
center <-state.center$us



#Pull in my data on Home Health
costs <- read.csv("quint.csv")

head(costs)
head(us)
names(costs)

colnames(costs)[1] <-"region"

snames <- aggregate(cbind(long,lat)~ region, data =us,
                    FUN=function(x)mean(range(x)))

head(snames)

snames.abr <-merge(snames, interest, by="region" )

head(snames.abr)

abr <- snames.abr[c(1:51), c(1, 2, 3, 4)]



#I must select first what rows and then the columbs I want
interest <- costs[c(1:51), c(1,2, 8, 18 ,21, 43, 44, 45)]

head(interest)

theme_update(plot.title = element_text(hjust = 0.5))

gg <- ggplot()

gg <- gg + geom_map(data=us, map=us,
                    aes(long, lat , map_id=region),
                    fill="#ffffff", color="#ffffff", size=.15)

gg <- gg + geom_map(data = interest , map = us, 
                   aes(fill = costquintile, map_id = region),
                   color ="#ffffff", size=.15)


gg <- gg + scale_fill_continuous(low='lightblue', high='darkblue', 
                                   guide = 'colorbar')
gg <- gg + labs(x=NULL, y=NULL)
gg <- gg + coord_map("albers", lat0 = 39, lat1 = 45) 
gg <- gg + theme(panel.border = element_blank())
gg <- gg + theme(panel.background = element_blank())
gg <- gg + theme(axis.ticks = element_blank())
gg <- gg + theme(axis.text = element_blank())
gg <- gg + ggtitle("States by Quintile of Cost in Home Health Sector\n 2 Year End of Life Expenditure Index")
gg <- gg + geom_text(data = abr, aes(long, lat ,label= abr), colour= 'white', size=2)
gg