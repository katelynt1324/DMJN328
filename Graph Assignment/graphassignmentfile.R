install.packages("ggrepel")
install.packages("ggplot2")
library(ggplot2)
food <- read.csv("food.csv")
head(Food)

ggplot(data = food, aes(x = ï..identity, y = percent, fill=level)) +
  geom_bar(stat="identity") +
  coord_flip() +
  ggtitle("Level of Food Security Among \nAboriginal Peoples in Canada") +
  xlab("Aboriginal Identiy") + ylab("Percent of Population") +
  labs(fill = "Level of Food Security") +
  labs(caption = "Source: Statistics Canada") +
  scale_fill_brewer(palette="Dark2")

 

library(ggthemes)

