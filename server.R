server <- function(input, output) {

  # --------- IMAGE IMDB
  output$image1 <- renderImage({
    width = "100%"
    height = 150
    list(src = "assets/IMDB.png",
         contentType = "image/jpg",
         width = width,
         height = height
    )
  }, deleteFile = FALSE)
  
  # ---------- LINE PLOT TAHUN 
  output$plot_year <- renderPlotly({
    movie_year <- movie %>% 
      group_by(year) %>% 
      summarise(count = n()) %>% 
      ungroup() %>% 
      mutate(label = glue(
        "Year: {year}
        Count: {count}"
                      )
      )
    
    plot1 <- ggplot(movie_year, aes(x = year, y = count)) +
      scale_x_continuous(breaks = c(1926, 1950, 1974, 1996, 2020)) +
      geom_line(col = "#B99A1C") +
      geom_point(aes(text = label), col = "#C31FB4") +
      labs(
        x = "year",
        y = "count"
      ) + 
      theme_classic()
    
    ggplotly(plot1, tooltip="text")
  })
  
  # --------- PLOT 3
  output$plot3 <-  renderBillboarder({
    movie_rating <- movie %>% 
      filter(rating != "Unrated") %>% 
      group_by(rating) %>% 
      summarise(count = n())
    billboarder() %>% bb_donutchart(movie_rating) %>% bb_legend(position = 'right') 
  })
  
  # --------- PLOT 2
  output$plot2 <-  renderBillboarder({
    movie_genres <- movie %>% 
      group_by(genre) %>% 
      summarise(count = n())
    billboarder() %>% bb_donutchart(movie_genres) %>% bb_legend(position = 'right') 
  })
  
  # --------- PLOT 4
  output$plot4 <-  renderPlotly({
    movie_genre <- movie %>% 
      group_by(genre) %>% 
      summarise(count = n()) %>% 
      ungroup() %>% 
      arrange(desc(count))
    
    plot_ly(
      movie_genre,
      labels = ~ genre,
      parents = NA,
      values = ~ count,
      type = 'treemap',
      hovertemplate = "Genre: %{label}<br>Count: %{value}<extra></extra>"
    )
  })
  
  # --------- PLOT 5
  output$plot5 <-  renderPlotly({
    movie_ratings <- movie %>% 
      filter(rating != "Unrated") %>% 
      group_by(rating) %>% 
      summarise(count = n()) %>% 
      ungroup() %>% 
      arrange(desc(count))
    
    plot_ly(
      movie_ratings,
      labels = ~ rating,
      parents = NA,
      values = ~ count,
      type = 'treemap',
      hovertemplate = "Rating: %{label}<br>Count: %{value}<extra></extra>"
    )
  })
  
  # --------- PLOT 6
  output$topchoice5 <- renderPlotly({
    topchoicemovie5 <- movie %>% 
      filter(year >= input$chooseyear[1] & year <= input$chooseyear[2]) %>% 
      filter(genre %in% input$genreFilter) %>% 
      filter(languages %in% input$languageFilter) %>% 
      filter(rating %in% input$ratingFilter) %>% 
      arrange(-score) %>% 
      select(title, score, year) %>% 
      mutate(label = glue(
        "Title: {title}
        Released Year: {year}
        Score: {round(score,5)}"
      )) %>% 
      head(5)
    plot6 <- ggplot(data = topchoicemovie5, aes(x = score, 
                                              y = reorder(title, score), # reorder(A, berdasarkan B)
                                              text = label)) + 
      geom_col(aes(fill = score)) +
      scale_fill_gradient(low="green", high="black") +
      labs(x = "Score",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
  
    ggplotly(plot6, tooltip = "text")
  })

  # --------- PLOT 7
  output$topchoice10 <- renderPlotly({
    topchoicemovie10 <- movie %>% 
      filter(year >= input$chooseyear[1] & year <= input$chooseyear[2]) %>% 
      filter(genre %in% input$genreFilter) %>% 
      filter(languages %in% input$languageFilter) %>% 
      filter(rating %in% input$ratingFilter) %>% 
      arrange(-score) %>% 
      select(title, score, year) %>% 
      mutate(label = glue(
        "Title: {title}
        Released Year: {year}
        Score: {round(score,5)}"
      )) %>% 
      head(10)
    
    plot7 <- ggplot(data = topchoicemovie10, aes(x = score, 
                                                y = reorder(title, score), # reorder(A, berdasarkan B)
                                                text = label)) + 
      geom_col(aes(fill = score)) +
      scale_fill_gradient(low="green", high="black") +
      labs(x = "Score",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(plot7, tooltip = "text")
  })
  
  # --------- PLOT 8
  output$topactor10 <- renderPlotly({
    topchoiceactor10 <- movie_actor %>% 
      filter(V1 == input$selectactor) %>% 
      arrange(-score) %>% 
      select(title, score, year) %>% 
      mutate(label = glue(
        "Title: {title}
        Released Year: {year}
        Score: {round(score,5)}"
      )) %>% 
      head(10)
    
    plot8 <- ggplot(data = topchoiceactor10, aes(x = score, 
                                                 y = reorder(title, score), # reorder(A, berdasarkan B)
                                                 text = label)) + 
      geom_col(aes(fill = score)) +
      scale_fill_gradient(low="green", high="black") +
      labs(x = "Score",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(plot8, tooltip = "text")
  })
  
  # --------- PLOT 9
  output$topactor5 <- renderPlotly({
    topchoiceactor5 <- movie_actor %>% 
      filter(V1 == input$selectactor) %>% 
      arrange(-score) %>% 
      select(title, score, year) %>% 
      mutate(label = glue(
        "Title: {title}
        Released Year: {year}
        Score: {round(score,5)}"
      )) %>% 
      head(5)
    
    plot9 <- ggplot(data = topchoiceactor5, aes(x = score, 
                                                 y = reorder(title, score), # reorder(A, berdasarkan B)
                                                 text = label)) + 
      geom_col(aes(fill = score)) +
      scale_fill_gradient(low="green", high="black") +
      labs(x = "Score",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(plot9, tooltip = "text")
  })
  
  # --------- PLOT 10
  output$topdirector10 <- renderPlotly({
    topchoicedirector10 <- movie %>% 
      filter(directors == input$selectdirector) %>% 
      arrange(-score) %>% 
      select(title, score, year) %>% 
      mutate(label = glue(
        "Title: {title}
        Released Year: {year}
        Score: {round(score,5)}"
      )) %>% 
      head(10)
    
    plot10 <- ggplot(data = topchoicedirector10, aes(x = score, 
                                                 y = reorder(title, score), # reorder(A, berdasarkan B)
                                                 text = label)) + 
      geom_col(aes(fill = score)) +
      scale_fill_gradient(low="green", high="black") +
      labs(x = "Score",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(plot10, tooltip = "text")
  })
  
  # --------- PLOT 11
  output$topdirector5 <- renderPlotly({
    topchoicedirector5 <- movie %>% 
      filter(directors == input$selectdirector) %>% 
      arrange(-score) %>% 
      select(title, score, year) %>% 
      mutate(label = glue(
        "Title: {title}
        Released Year: {year}
        Score: {round(score,5)}"
      )) %>% 
      head(5)
    
    plot11 <- ggplot(data = topchoicedirector5, aes(x = score, 
                                                     y = reorder(title, score), # reorder(A, berdasarkan B)
                                                     text = label)) + 
      geom_col(aes(fill = score)) +
      scale_fill_gradient(low="green", high="black") +
      labs(x = "Score",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(plot11, tooltip = "text")
  })
  
  # ----------- DATASET
  output$dataset_table <- renderDataTable(movie[,c("title","year","description","genre","runtime","rating","languages","directors","actors","users_rating","votes","score")],
                            options = list(scrollX = T, scrollY = T))
}