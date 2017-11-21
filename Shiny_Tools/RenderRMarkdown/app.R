

shinyApp(
  ui = fluidPage(
    sliderInput("slider", "Slider", 1, 100, 50),
    downloadButton("report", "Generate report")
  ),
  server = function(input, output) {
    
    Test1=c(1:2)
    
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
        params <- list(n = input$slider,x=Test1)
        
        # Knit the document, passing in the `params` list, and eval it in a
        # child of the global environment (this isolates the code in the document
        # from the code in this app).
        
        #https://stackoverflow.com/questions/34029611/how-to-use-objects-from-global-environment-in-rstudio-markdown
        #save(Test1,file="global.RData")
        
        rmarkdown::render(tempReport, output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
      }
    )
  }
)