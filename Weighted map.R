install.packages("ggplot2")
install.packages("fiftystater")
install.packages("mapproj")
library(ggplot2)
library(fiftystater)

data("fifty_states") #This line is optional due to lazy data loading

#importing the data set I want to use. I have my directory set to access file
costs <- read.csv("costquality.csv")

#display the variable names
names(costs)

#I must select first what rows and then the columbs I want
interest <- costs[c(1:51), c(1,2, 7, 11, 12, 18, 44, 46, 60, 61)]
#What variables do I have in my interest data set
names(interest)
#generates the proper theme formating for the graphic title
theme_update(plot.title = element_text(hjust = 0.5))

##########################################################################
##### First Map#########################################################

p <- ggplot(interest, aes(map_id = state))+
  
  #Adding in the title of the graphic
  
  ggtitle("States by Quintile of Cost in Home Health Care\n Adjusted by Price, Age, Sex, and Race")+
  geom_map(aes(fill = costquin ), map = fifty_states,)+ 
  
  #This fill gradient allows me to contorl the fill colors and add titles to the legend.
  
  scale_fill_gradient(low='lightblue', high='darkblue', guide = 'colorbar', name ="Quintiles of Cost",
                      labels=c("Quintile 1 - $198.24", "Quintile 2 - $343.43","Quintile 3 - $428.34" , "Quintile 4 - $514.13" ,"Quintile 5 - $800.72"),
                      breaks= c(1,2,3,4,5)) +                     
                            
  geom_map(aes(fill = costquin ), map = fifty_states, color="white", size=.25)+ 
  expand_limits(x = fifty_states$long, y= fifty_states$lat)+
  coord_map()+
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  labs(x= "", y="") +
  
  #Position where I want the legend to be on the paper 
  
  theme(
        legend.position = "right",
        panel.background = element_blank())
p + fifty_states_inset_boxes()


##########################################################################
##### Second Map#########################################################

##double check what vars I have
head(interest)

p <- ggplot(interest, aes(map_id = state))+
  
  #Adding in the title of the graphic
  
  ggtitle("States by Cost Quintile of Average Hospitalizations of Home Health Patients\n Sourced from CMS Home Health Compare")+
  geom_map(aes(fill = quinthosp ), map = fifty_states,)+ 
  
  #This fill gradient allows me to contorl the fill colors and add titles to the legend.
  
  scale_fill_gradient(low='lightblue', high='darkblue', guide = 'colorbar', name ="Avg Hospitalization Rates",
                      labels=c("Lowest Rate","Highest Rate"),
                      breaks= c(15.41059,16.222424)) +  
  
  geom_map(aes(fill = quinthosp ), map = fifty_states, color="white", size=.25)+ 
  expand_limits(x = fifty_states$long, y= fifty_states$lat)+
  coord_map()+
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  labs(x= "", y="") +
  
  #Position where I want the legend to be on the paper 
  
  theme(
    legend.position = "right",
    panel.background = element_blank())
p + fifty_states_inset_boxes()

##########################################################################
##### Third Map#########################################################

##double check what vars I have
head(interest)

p <- ggplot(interest, aes(map_id = state))+
  
  #Adding in the title of the graphic
  
  ggtitle("States by Cost Quintile of Average Home Health Emergency Room Visits\n Not Leading to Hospital Admission")+
  geom_map(aes(fill = quintemer ), map = fifty_states,)+ 
  
  #This fill gradient allows me to contorl the fill colors and add titles to the legend.
  
  scale_fill_gradient(low='lightblue', high='darkblue', guide = 'colorbar', name ="Avg Emergency Rates",
                      labels=c("Lowest Rate","Highest Rate"),
                      breaks= c(12.437973,14.010116)) +  
  
  geom_map(aes(fill = quintemer ), map = fifty_states, color="white", size=.25)+ 
  expand_limits(x = fifty_states$long, y= fifty_states$lat)+
  coord_map()+
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  labs(x= "", y="") +
  
  #Position where I want the legend to be on the paper 
  
  theme(
    legend.position = "right",
    panel.background = element_blank())
p + fifty_states_inset_boxes()
