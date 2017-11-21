source("global.R")




ui <- dashboardPage(skin = "blue",

## Header
  dashboardHeader(
  title = "My Dashboard",
  titleWidth = 350,



      ## Message menus (static)
      dropdownMenu(type = "messages",
        messageItem(
        from = "Sales Dept",
        message = "Sales are steady this month."
        ),
        messageItem(
        from = "New User",
        message = "How do I register?",
        icon = icon("question"),
        time = "13:45"
        ),
        messageItem(
        from = "Support",
        message = "The new server is ready.",
        icon = icon("life-ring"),
        time = "2014-12-01"
        )
        )
      ##
       ,
      dropdownMenu(type = "notifications",
          notificationItem(
            text = "5 new users today",
            icon("users")
          ),
          notificationItem(
            text = "12 items delivered",
            icon("truck"),
            status = "success"
          ),
          notificationItem(
            text = "Server load at 86%",
            icon = icon("exclamation-triangle"),
            status = "warning"
          )
        )

        ##############
        ,


        ### Task menu
        dropdownMenu(type = "tasks", badgeStatus = "success",
          taskItem(value = 90, color = "green",
            "Documentation"
          ),
          taskItem(value = 17, color = "aqua",
            "Project X"
          ),
          taskItem(value = 75, color = "yellow",
            "Server deployment"
          ),
          taskItem(value = 80, color = "red",
            "Overall project"
          )
        )
        ###########3
        ########3
    
  ),

    ## Sidebar content
    sidebar,

  ## Body content
dashboardBody(
    tabItems(
# First tab content
      tabItem(tabName = "dashboard",
        fluidRow(


          box(plotOutput("plot1", height = 250)),


          box(
            "Box content here", br(), "More box content",
            sliderInput("slider", "Slider input:", 1, 100, 50),
            textInput("text", "Text input:")
            )

            ,

            fluidRow(

            box(
  title = "Histogram", status = "primary", solidHeader = TRUE,
  collapsible = TRUE,
  plotOutput("byQuarter", height = 250)
),

box(
  title = "Inputs", status = "warning", solidHeader = TRUE,
  "Box content here", br(), "More box content",
  sliderInput("slider2", "Slider input:", 1, 100, 50),
  textInput("text", "Text input:")
),

################# Input symbol
box(
  title = "Inputs2", status = "warning", solidHeader = TRUE,
  selectInput("symbol", "Symbol:", 
              choices=ticker),
  hr(),
  helpText("Data from AT&T (1961) The World's Telephones.")
  
  
  
)

)


        )
      ),

# Second tab content
      tabItem(tabName = "widgets",
        fluidRow(
        tabBox(
        title = "First tabBox",
        # The id lets us use input$tabset1 on the server to find the current tab
        id = "tabset1", height = "250px",
        tabPanel("Tab1", "First tab content"),
        tabPanel("Tab2", plotOutput("byQuarterAll", height = 250))
        ),
        tabBox(
        side = "right", height = "250px",
        selected = "Tab3",
        tabPanel("Tab1", tableOutput('tbl2')),
        tabPanel("Tab2", "Tab content 2"),
        tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
        )
        ),
        fluidRow(
        tabBox(
        # Title can include an icon
        title = tagList(shiny::icon("gear"), "tabBox status"),
        tabPanel("Tab1",
        "Currently selected tab from first box:",
        verbatimTextOutput("tabset1Selected")
        ),
        tabPanel("Tab2", "Tab content 2")
        )
        )
      ),


      # GDP tab content
tabItem(tabName = "GDP",
        tabsetPanel(id = "continent",
        tabPanel("Test"),
            tabPanel("Asia", gapModuleUI("asia")),
            tabPanel("Europe", tableTestUI("test")),
            tabPanel("Oceania", DT::dataTableOutput("tbl"))#,
           # tabPanel("test", DT::dataTableOutput("tbl")),
        )
        
      )
       ,


tabItem(tabName = "Input",
        tabsetPanel(id = "continent2",
        tabPanel("Test2"),
            tabPanel("Asia2", DragDropUI("dragdrop")),
            tabPanel("Europe2", sliderInput("slider5", "Slider", 1, 100, 50),
            downloadButton("report", "Generate report")),
            tabPanel("Oceania2", includeHTML("render/Charts_buttons.html"))
        )

        )
        ,

tabItem(tabName = "Input2","test"

        )




    )

)






#End UI
)

server <- function(input, output,session) {


    output$tbl2 <- renderTable({
                head(rock, n = 6) },
                 digits = 2)



    ##menu item
    output$menuitem <- renderMenu({
    menuItem("Menu item", icon = icon("calendar"))
    })






    set.seed(122)
    histdata <- rnorm(500)

    output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
     })


    callModule(gapModule, "asia", asia_data)
    callModule(gapModule, "europe", europe_data)
    callModule(gapModule, "oceania", oceania_data)
    callModule(tableTest, "test")
    callModule(DragDrop, "dragdrop")
    callModule(DragDrop, "dragdrop2")


    ### Render RMarkdown

#    rmarkdown::render("render/rmarkdown_dynamicInput.Rmd", params = list(
#  region = "north",
#  start = "start"
#))

    #https://shiny.rstudio.com/articles/generating-reports.html
    output$report <- downloadHandler(
# For PDF output, change this to "report.pdf"
      filename = "report.html",
      content = function(file) {
          # Copy the report file to a temporary directory before processing it, in
          # case we don't have write permissions to the current working dir (which
          # can happen when deployed).
          tempReport <- file.path(tempdir(), "report.Rmd")
          file.copy("report.Rmd", tempReport, overwrite = TRUE)

          # Set up parameters to pass to Rmd document
          params <- list(n = input$slider5)

          # Knit the document, passing in the `params` list, and eval it in a
          # child of the global environment (this isolates the code in the document
          # from the code in this app).
   

          rmarkdown::render(tempReport, output_file = file,
          params = params,
          envir = new.env(parent = globalenv())
        )
      }
    )






    
    output$tbl = DT::renderDataTable(
      #iris, options = list(lengthChange = FALSE)
      Quotes_by_qtr
      )
    ########
    ##
    ######
    source("Portfolio_Scenarios/SingleAssets.R")
    output$plot3 <- renderPlot({
    plot3
    })
    #########
    #### Plot
    ##################################################################################
    output$byQuarter <- renderPlot({
      source("Portfolio_Scenarios/plot_SymbolbyQuarter.R",local=T)
      byQuarter
    })
    ###################################################################################
    output$byQuarterAll <- renderPlot({
      byQuarterAll
    })
    
    #Automatically stop a Shiny app when closing the browser tab
    session$onSessionEnded(stopApp)
}



shinyApp(ui, server)