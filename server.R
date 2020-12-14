
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
# library(tm)
library(xlsx)
library(twitteR)
library(RJSONIO)
library(stringr)
library(RCurl)
require(quanteda)


shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    
#       consumer_key <- 'HU5NNkUEeZRyVOWQnQnGtE5So'
#       consumer_secret <- 'r4Ohzj6f1duxWmfbssbsKuvBAb6ORftya7j2qFSELbmxVwOfU8'
#       access_token <- '2846628114-kgETRHBwrstuoaeIjZfCzXe6sm5D94DtMbBwgh8'
#       access_key <- 'EieK1761M1N3csv99n6HQIxXFIat8VxlOtmifQPrAkZrU'
#       
#       setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_key)
    
      # Get the twitter data with in that date range
      hot_tweet <- searchTwitter("[a-zA-Z]", n = input$bins , since = as.character(input$date_s), until = as.character(input$date_e))
      
      # Convet that to data frame
      hot_tweet_data <- twListToDF(hot_tweet)
      
      # Remove the comments from the data
      hot_tweet_data <- subset(hot_tweet_data,isRetweet == "FALSE")
      
      # Get the data that contains hash tag values
      hash_comm <- hot_tweet_data$text[grepl("[\\#]+[a-zA-Z]",hot_tweet_data$text)]
      
      # get all the hash tag values
      Z <- str_extract_all(hash_comm, '#\\w*')
      
      # Convert the list value to vector
      Unigram <- NULL
      for (i in 1:length(Z)) {
        for(j in 1:length(Z[[i]])){
          Unigram <- c(Unigram,Z[[i]][j])
        }
      }
      
      # Get the frequency of all words
      tag_value_freq <- table(Unigram)
       # List_of_hashTag <- unlist(strsplit(Z[[1]][1:2], "\\#"))
      
#       Hash_tag_value <- gsub("([A-Za-z]+).*", "\\1", List_of_hashTag)
#       
#       Hash_tag_value <- Hash_tag_value[grepl("[a-zA-Z]",Hash_tag_value)]
#       
#       tag_value_freq <- table(Hash_tag_value[grepl("[a-zA-Z]",Hash_tag_value)])
      
      # Sort top five values or top highest frequency words
      X <- as.table(head(sort(tag_value_freq, decreasing = TRUE),5))
      
      # Plot the Chart
      barplot(X)
    # draw the histogram with the specified number of bins
    

  })

})
