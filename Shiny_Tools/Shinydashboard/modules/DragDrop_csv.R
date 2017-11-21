####Log
#

#module wrapper
DragDropUI <- function(id) {
    ns <- NS(id)

    #  tagList(

  #module wrapper

  #comment
    #ui <-
  #
fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      fileInput(ns("file1"), "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      tags$hr(),
      checkboxInput(ns("header"), "Header", TRUE)
    ),
    mainPanel(
      tableOutput(ns("contents"))
    )
  )
  
  
      
    






  )
}



DragDrop <- function(input, output, session) {
#server <- function(input, output) {

  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header)
    
    
  })
 # csv_file=read.csv(inFile$datapath, header = input$header)
#return(csv_file)
}

#shinyApp(ui, server)