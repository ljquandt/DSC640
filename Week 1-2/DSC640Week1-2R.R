library(ggplot2)
library(readxl)
library(tidyverse)
library(plyr)
library(dplyr)
library(pastecs)

#set working directory
setwd('/Users/logan/Documents/GitHub/DSC640')

#load in obama approval dataset
obama_df <- read_excel("/Users/logan/Documents/GitHub/DSC640/obama-approval-ratings.xls")

#load in hotdog contest winner dataset
hotdog_df <- read_excel("/Users/logan/Documents/GitHub/DSC640/hotdog-contest-winners.xlsm")

#check colnames for hotdog_df
head(hotdog_df)

#correct colnames for use in graphs
colnames(hotdog_df)[colnames(hotdog_df) == 'Dogs eaten'] <- 'Dogs_eaten'

#create a horizontal barchart
barc <- ggplot(data = hotdog_df, aes(x = Winner, y=Dogs_eaten)) + geom_bar(stat='identity', color='Blue', fill='Blue') + theme_minimal() + coord_flip()
barc

#create a line chart
lineplot <- ggplot(data=hotdog_df, aes(x=Year,y=Dogs_eaten)) + geom_line()
lineplot

#load in reshape 2 library
library(reshape2)

#melt obama_df for use in stacked bar chart
obama_df_two <- melt(obama_df, id.vars = 1)
#create stacked bar chart
stackedbar <- ggplot(data=obama_df_two, aes(fill=variable, x=Issue, y=value)) + geom_bar(position='stack', stat='identity') + scale_fill_manual(values = c('Green','Red','Grey')) + coord_flip()
stackedbar

#create variable for Obamas ratings on Education
rating <- c(obama_df$Approve[2], obama_df$Disapprove[2], obama_df$None[2])
#create variable for type of rating
type <- c('Approve', 'Disapprove', 'None')
#create new dataframe for use in piechart
approve_df <- data.frame(group=type, value=rating)
#create piechart
piechart <- ggplot(data=approve_df, aes(fill=group, y=value, x="")) + geom_bar(stat='identity', width=1, color='White') + coord_polar('y', start=0) + theme_void()
piechart

#set holesize for donut chart
hsize=3

#create donut chart
donut <- piechart <- ggplot(data=approve_df, aes(fill=group, y=value, x=hsize)) + geom_bar(stat='identity', width=1) + coord_polar('y') + theme_void() +xlim(c(0.2,hsize + 0.5))
donut


