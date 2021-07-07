#Usually we would comment these out 
#install.packages("ggrepel")
#install.packages("ggplot2")
library(ggplot2)
#It's always a good idea to read in csv files with stringsAsFactors=F
food <- read.csv("food.csv", stringsAsFactors = F)
head(food)

ggplot(data = food, aes(x = identity, y = percent, fill=level)) +
  geom_bar(stat="identity") +
  coord_flip() +
  ggtitle("Level of Food Security Among \nAboriginal Peoples in Canada") +
  xlab("Aboriginal Identiy") + ylab("Percent of Population") +
  labs(fill = "Level of Food Security") +
  labs(caption = "Source: Statistics Canada") +
  scale_fill_brewer(palette="Dark2")

 

library(ggthemes)

#here is How I would recode the long First Nations labels. 


#There are two ways to deal with the long first nations label. 
# The first way would be to recode them. 
library(tidyverse)
#Start with the data frame and pipe
food %>% 
  #mutate to create a new variable identity 2 based on the conditions in case_when
  mutate(identity2=case_when(
    #when identity == ...... set identity 2 to be Treaty First Nations
    identity=="First Nations (North American Indian) Registered or Treaty Indian" ~ "Treaty First Nations",
    #when identity == blah blah, set identity2 to be Not Registered or Treaty
    identity=="First Nations (North American Indian) NOT Registered or Treaty Indian" ~ "Non-Treaty First Nations",
    #All other categories just use what is in identity as a character string, not a factor
    TRUE ~ as.character(identity)
    #Then save
  )) -> food

#Now check 
names(food)
table(food$identity2)

#But the other way would be just to filter them out. The reason this works is that the category "First Nations (NOrth American Indian) *already* includes both status and non-status Indians in it. So unless you are really interested in distinguishing between the two, you could just drop them. 

#Start with the data frame and pipe
food %>% 
  #filter 
  filter(identity!="First Nations (North American Indian) NOT Registered or Treaty Indian" & identity!="First Nations (North American Indian) Registered or Treaty Indian") -> food2

#check what is left
table(food2$identity)
#I'll just play with food2

#Here is your codefrom above 
#notice I'm using food2 and the identity variable instead of food. 
ggplot(data = food2, aes(x = identity, y = percent, fill=level)) +
  geom_bar(stat="identity") +
  coord_flip() +
 ##This line isn't necessary, because you can set the title below. 
  ## ggtitle("Level of Food Security Among \nAboriginal Peoples in Canada") +
  xlab("Aboriginal Identiy") + ylab("Percent of Population") +
  labs(title="Level of Food Security Among \nAboriginal Peoples in Canada", fill = "Level of Food Security",caption = "Source: Statistics Canada") +
scale_fill_brewer(palette="Dark2")

##But you also have this problem that you have this category "Not Specified that is in the middle of your levels of food security. It interrupts the information flow. 

#I would filter it out.
#start with the data frame and pipe
food2 %>% 
#filter out level =="not specified  
  filter(level!="Not Specified") %>% 
  #You can proceed right to the graph
  #notice I'm using food2 instead of food. 
  ggplot(.,aes(x = identity, y = percent, fill=level)) +
  geom_bar(stat="identity") +
  coord_flip() +
  ##This line isn't necessary, because you can set the title below. 
  ## ggtitle("Level of Food Security Among \nAboriginal Peoples in Canada") +
  xlab("Aboriginal Identiy") + ylab("Percent of Population") +
  labs(title="Level of Food Security Among \nAboriginal Peoples in Canada", fill = "Level of Food Security",caption = "Source: Statistics Canada") +
  scale_fill_brewer(palette="Dark2")

#The other issue is that it doesn't make sense to include have the categories go from Very Low to High. High is the worst category, I feel like it should be at the bottom. 

#to fix this, we need to specify what order they should be printed in. 
#We need to set level as a factor with the levels ofthe factor in the order we want. 
table(food2$level)
food2$level<-factor(food2$level, levels=c("Very Low", "Low", "Not Specified", "High Or Marginal"))

#start with the data frame and pipe
food2 %>% 
  #filter out level =="not specified  
  filter(level!="Not Specified") %>% 
  #You can proceed right to the graph
  #notice I'm using food2 instead of food. 
  ggplot(.,aes(x = identity, y = percent, fill=level)) +
  geom_bar(stat="identity") +
  coord_flip() +
  ##This line isn't necessary, because you can set the title below. 
  ## ggtitle("Level of Food Security Among \nAboriginal Peoples in Canada") +
  xlab("Aboriginal Identiy") + ylab("Percent of Population") +
  labs(title="Level of Food Security Among \nAboriginal Peoples in Canada", fill = "Level of Food Security",caption = "Source: Statistics Canada") +
  scale_fill_brewer(palette="Dark2")
