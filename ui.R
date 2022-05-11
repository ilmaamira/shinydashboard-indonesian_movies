dashboardPage(
  
  
  skin = "yellow",
  
  
  # --------- HEADER
  dashboardHeader(
    title = div(h1('Indonesian Movies', style = "margin: 2px; font-size: 22px"), h2('Based on IMDb Rating', style = "margin: 2px; font-size: 16px"))
  ),
  
  
  # --------- SIDEBAR
  dashboardSidebar(
    sidebarMenu(
      menuItem("IMDb - About", tabName = "about", icon = icon("imdb")),
      menuItem("Data Summary", tabName = "summary", icon = icon("list")),
      menuItem("Movie Analysis 1", tabName = "analysis1", icon = icon("film")),
      menuItem("Movie Analysis 2", tabName = "analysis2", icon = icon("film")),
      menuItem("Dataset", tabName = "data", icon = icon("server"))
    )
  ),
  
  
  # --------- BODY
  dashboardBody(
    tags$head(tags$style(HTML('
 .nav-tabs-custom>.nav-tabs {
     background-color: orange;
 }
 .nav-tabs-custom > .nav-tabs > li.header {
     color: white; 
 }
 .box-header h3 {
   font-weight: bold;
 }'))),
    
    tabItems(
      
      # --------- Page 1
      tabItem(tabName = "about",
              
              # --------- ROW 1
              fluidRow(
                box(
                  width = 8,
                  height = 0,
                  solidHeader = TRUE,
                  strong("What is IMDb Rating?", style = "font-family: 'times'; font-size: 20pt"),
                  br(),
                  br(),
                  p("IMDb is an online database of information related to movies, television series, home videos, video games, and streaming content online – including cast, production crew and personal biographies, plot summaries, trivia, ratings, also fan and critical reviews.", style = "font-family: 'times'; font-size: 10pt"),
                  br(),
                  strong("How does IMDb's Rating System Work?", style = "font-family: 'times'; font-size: 20pt"),
                  br(),
                  p("IMDb registered users can cast a vote/score (from 1 to 10) on every released title in the database. Individual votes are then aggregated and summarized as a single IMDb rating, visible on the title’s main page. To calculate the ratings, IMDb uses a weighted average, so that all votes don’t have the same impact (or ‘weight’) on the final rating. The users can update their votes as often as they’d like, but any new vote on the same title will overwrite the previous one, so it is one vote per title per user.", style = "font-family: 'times'; font-size: 10pt")
                ),
                box(imageOutput("image1"),
                    width = 4,
                    height = 0,
                    solidHeader = TRUE
                ),
              )
      ),
      
      # --------- Page 2
      tabItem(tabName = "summary",
              
              # --------- ROW 1
              fluidRow(
                box(width = 12,
                    background = "green",
                    solidHeader = FALSE,
                    p("The graphs are made from the dataset which contain information of Indonesian movies listed on IMDb, especially from 1926-2020.", align = "center", style = "font-size: 12pt")
                )
              ),
              
              # --------- ROW 2
              fluidPage(
                box(width = 9,
                    title = "Number of Movies Released per Year",
                    solidHeader = TRUE,
                    status = 'warning',
                    plotlyOutput("plot_year")
                ),
                valueBox(
                  icon = tags$i(class = "fas fa-film", style = "font-size: 80%"),
                  subtitle = tags$p("Total Movies", style = "font-size: 110%;"),
                  value = tags$p("1272", style = "font-size: 86%;"),
                  color = "red",
                  width = 3
                ),
                valueBox(
                  icon = tags$i(class = "fas fa-clock", style = "font-size: 65%"),
                  subtitle = tags$p("Average Runtime", style = "font-size: 110%;"),
                  value = tags$p("97 min", style = "font-size: 78%;"),
                  color = "light-blue",
                  width = 3
                ),
                valueBox(
                  icon = tags$i(class = "fas fa-user", style = "font-size: 68%"),
                  subtitle = tags$p("Total Directors", style = "font-size: 110%;"),
                  value = tags$p("380", style = "font-size: 88%;"),
                  color = "purple",
                  width = 3
                ),
                valueBox(
                  icon = tags$i(class = "fas fa-mask", style = "font-size: 65%"),
                  subtitle = tags$p("Total Main Actors", style = "font-size: 110%;"),
                  value = tags$p("5077", style = "font-size: 88%;"),
                  color = "orange",
                  width = 3
                )
              ),
              fluidPage(
                tabBox(width = 12,
                       title = tags$b("Number of Movies Based on Rating"),
                       id = "tabset2",
                       side = "right",
                       tabPanel(tags$b("Pie Chart"), 
                                billboarderOutput("plot3")
                       ),
                       tabPanel(tags$b("Treemap"), 
                                plotlyOutput("plot5")
                       )    
                )
              ),
              fluidPage(
                tabBox(width = 12,
                       title = tags$b("Number of Movies Based on Genre"),
                       id = "tabset1",
                       side = "right",
                       tabPanel(tags$b("Pie Chart"), 
                                billboarderOutput("plot2")
                       ),
                       tabPanel(tags$b("Treemap"), 
                                plotlyOutput("plot4")
                       )    
                )
              )
      ),
      
      # --------- Page 3
      tabItem(tabName = "analysis1",
              
              # --------- ROW 1
              fluidRow(
                box(width = 12,
                    solidHeader = T,
                    background = "green",
                    height = 120,
                    setSliderColor("#F7C84C",1),
                    sliderInput("chooseyear", "Released Year:", min = 1926, max = 2020, value = c(1926,2020), step = 1, sep = ""
                    )
                )
              ),
              
              # --------- ROW 2
              fluidRow(
                box(width = 4,
                    solidHeader = T,
                    background = "green",
                    height = 55,
                    align = "center",
                    dropdownButton(
                      label = "Select Genre",
                      circle = FALSE,
                      width = 100,
                      box(width = 14,
                          solidHeader = T,
                          background = "yellow",
                          checkboxGroupInput('genreFilter', "Genre:",
                                             choices = unique(movie$genre),
                                             selected = unique(movie$genre)
                          )
                      )
                    )
                ),
                box(width = 4,
                    solidHeader = T,
                    background = "green",
                    height = 55,
                    align = "center",
                    dropdownButton(
                      label = "Select Rating",
                      circle = FALSE,
                      width = 100,
                      box(width = 14,
                          solidHeader = T,
                          background = "yellow",
                          checkboxGroupInput('ratingFilter', "Rating:",
                                             choices = unique(movie$rating),
                                             selected = unique(movie$rating)
                          )
                      )
                    )
                ),
                box(width = 4,
                    solidHeader = T,
                    background = "green",
                    height = 55,
                    align = "center",
                    dropdownButton(
                      label = "Select Language",
                      circle = FALSE,
                      width = 100,
                      box(width = 14,
                          solidHeader = T,
                          background = "yellow",
                          checkboxGroupInput('languageFilter', "Language:",
                                             choices = unique(movie$languages),
                                             selected = unique(movie$languages)
                          )
                      )
                    )
                )
              ),
              
              # --------- ROW 3
              fluidRow(
                tabBox(width = 12,
                       title = tags$b("Top Movies Based on IMDb Rating"),
                       id = "tabset3",
                       side = "right",
                       tabPanel(tags$b("Top 5"), 
                                plotlyOutput("topchoice5")
                       ),
                       tabPanel(tags$b("Top 10"), 
                                plotlyOutput("topchoice10")
                       )
                )
            )
      ),
      
      # --------- Page 4
      tabItem(tabName = "analysis2",
              
              # --------- ROW 1
              fluidRow(
                box(width = 3,
                    solidHeader = T,
                    background = "green",
                    height = 465,
                    selectInput(
                      inputId = "selectactor",
                      label = "Choose Actor",
                      choices = unique(freqactor$Var1)
                    )
                ),
                tabBox(width = 9,
                       title = tags$b("Top Movies Based on Actor"),
                       id = "tabset4",
                       side = "right",
                       tabPanel(tags$b("Top 5"), 
                                plotlyOutput("topactor5")
                       ),
                       tabPanel(tags$b("Top 10"), 
                                plotlyOutput("topactor10")
                                
                       )
                )
              ),
              # --------- ROW 2
              fluidRow(
                box(width = 3,
                    solidHeader = T,
                    background = "green",
                    height = 465,
                    selectInput(
                      inputId = "selectdirector",
                      label = "Choose Director",
                      choices = unique(movie$directors)
                    )
                ),
                tabBox(width = 9,
                       title = tags$b("Top Movies Based on Director"),
                       id = "tabset5",
                       side = "right",
                       tabPanel(tags$b("Top 5"), 
                                plotlyOutput("topdirector5")
                       ),
                       tabPanel(tags$b("Top 10"), 
                                plotlyOutput("topdirector10")
                                
                       )
                )
              )
              
      ),
      
      # --------- Page 5
      tabItem(tabName = "data",
              fluidRow(
                box(
                  width = 12,
                  dataTableOutput(outputId = "dataset_table")
                )
              )
      )
    )
  )
)