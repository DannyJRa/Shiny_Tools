library(shiny)

header <- dashboardHeader(
  title = "Claims Dashboard"
)

sidebar <- dashboardSidebar(
  dateInput(
    "val_date", 
    "Valuation Date",
    value = Sys.Date(),
    min = min(trans$accident_date),
    max = Sys.Date(),
    startview = "decade"
  ),
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Claim Changes", tabName = "changes", icon = icon("balance-scale")),
    menuItem("Claims Table", tabName = "table", icon = icon("table")),
    menuItem("Simulation",tabName="simulation",icon = icon("table"))
    
    ,menuItem("T-Bill",tabName="t-bill",icon = icon("table"))
  )
)

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    tags$script(src = "custom.js")
  ),
  tabItems(
    source("ui/01-dashboard-ui.R", local = TRUE)$value,
    source("ui/02-changes-ui.R", local = TRUE)$value,
    source("ui/03-simulation-ui.R", local = TRUE)$value,
    source("ui/04-t-bill-ui.R", local = TRUE)$value,
    tabItem(
      tabName = "table",
      fluidRow(
        box(
          width = 12,
          DT::dataTableOutput("trans_tbl")
        )
      ),
      fluidRow(
        column(
          width = 12,
          class = "text-center",
          br(),
          br(),
          hr(),
          h1("Historical Treasury Yields"),
          h3("(For Your Reference in Making Parameter Selections in Above Walk)"),
          br()
        )
      )
      
    
      
      ###############################
      
      
      
      
    )
  )
)

dashboardPage(
  header,
  sidebar,
  body,
  skin = "black"
)
