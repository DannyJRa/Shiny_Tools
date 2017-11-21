sidebar <- dashboardSidebar(
  sidebarMenu(id = "sidebar", #bookmarking
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("GDP", icon = icon("th"), tabName = "GDP",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Input", icon = icon("th"), tabName = "Input",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Input2", icon = icon("th"), tabName = "Input2",
             badgeLabel = "new", badgeColor = "green"),
    
             ##dynamic
    menuItemOutput("menuitem")
 )
)