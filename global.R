library(shiny)
library(shinydashboard)
library(stringr)
library(tidyr)
library(tidyverse)
library(plotly)
library(glue)
library(DT)
library(billboarder)
library(shinyWidgets)
library(data.table)

movie <- read.csv("data_input/indonesianmovies.csv", header = T, sep = ',', na.strings = c(""))

movie$votes <- str_replace_all(movie$votes,",","")
movie$runtime <- str_replace_all(movie$runtime,"min","")
movie$rating <- str_replace_all(movie$rating,"Not Rated","Unrated")
movie$rating <- str_replace_all(movie$rating,"Not Rated","Unrated")
movie$rating <- movie$rating %>% replace_na('Unrated')
movie$rating <- str_replace_all(movie$rating,"TV-14","13+")
movie$rating <- str_replace_all(movie$rating,"PG-13","13+")
movie$rating <- str_replace_all(movie$rating,"R","13+")
movie$rating <- str_replace_all(movie$rating,"TV-MA","17+")
movie$rating <- str_replace_all(movie$rating,"D","17+")
movie$actors <- str_replace_all(movie$actors,"\\[","")
movie$actors <- str_replace_all(movie$actors,"\\]","")

movie[762,"genre"] <- "Comedy"
movie[825,"genre"] <- "Comedy"
movie[827,"genre"] <- "Drama"
movie[857,"genre"] <- "Drama"
movie[900,"genre"] <- "Drama"
movie[939,"genre"] <- "Adventure"
movie[956,"genre"] <- "Drama"
movie[963,"genre"] <- "Romance"
movie[965,"genre"] <- "Drama"
movie[969,"genre"] <- "Romance"
movie[1009,"genre"] <- "Drama"
movie[1015,"genre"] <- "Drama"
movie[1041,"genre"] <- "Comedy"
movie[1048,"genre"] <- "Comedy"
movie[1071,"genre"] <- "Action"
movie[1076,"genre"] <- "Comedy"
movie[1085,"genre"] <- "Action"
movie[1092,"genre"] <- "Romance"
movie[1100,"genre"] <- "Drama"
movie[1122,"genre"] <- "Romance"
movie[1132,"genre"] <- "Drama"
movie[1137,"genre"] <- "Comedy"
movie[1139,"genre"] <- "Drama"
movie[1147,"genre"] <- "Drama"
movie[1153,"genre"] <- "Comedy"
movie[1156,"genre"] <- "Drama"
movie[1159,"genre"] <- "Action"
movie[1178,"genre"] <- "History"
movie[1182,"genre"] <- "Adventure"
movie[1196,"genre"] <- "Action"
movie[1204,"genre"] <- "History"
movie[1211,"genre"] <- "Comedy"
movie[1224,"genre"] <- "Drama"
movie[1231,"genre"] <- "Romance"
movie[1240,"genre"] <- "Action"
movie[1259,"genre"] <- "History"

movie[138,"directors"] <- "Amar Mukhi"
movie[223,"directors"] <- "Tema Patrosza"
movie[427,"directors"] <- "Indra Gunawan"
movie[1023,"directors"] <- "Steady Rimba"
movie[1047,"directors"] <- "Steady Rimba"
movie[1256,"directors"] <- "A.N. Alcaff"
movie[1271,"directors"] <- "Nancing movie Corp."

movie[movie$title == "Iseng","rating"] <- "21+"
movie[movie$title == "Wanita Dalam Gairah","rating"] <- "21+"
movie[movie$title == "Bibir Mer","rating"] <- "21+"

movie$votes <- as.numeric(movie$votes)
movie$runtime <- as.numeric(movie$runtime)
movie$year <- as.numeric(movie$year)
movie[,c("genre","rating","languages")] <- lapply(movie[,c("genre","rating","languages")],as.factor)

movie$score <- movie$users_rating * (movie$votes/sum(movie$votes))
movie$id <- 1:nrow(movie)

movie$rating <- droplevels(movie$rating)

dt <- data.table(movie)
movie_actor <- dt[,strsplit(actors,", ",fixed = T),by = c("id","score","title","year")]
freqactor <- (as.data.frame(sort(table(movie_actor$V1), decreasing = T)))[-1,]


