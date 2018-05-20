### Shiny_Laborkumulativbericht


library(shiny)
library(shinythemes)
library(ggplot2)
library(scales)
library(readr)

# lädt das Laborfile 
labor = read.csv(file = "https://raw.githubusercontent.com/dr-xenia/laborbericht/master/labor.csv", header =
                         TRUE, sep = ",")

# richtige Formattierung des Datums
labor$Datum <- as.Date(labor$Datum)


# definiert das User Interface
ui <- fluidPage(theme = shinytheme("simplex"),
        
        #Titel
        titlePanel("Laborkumulativbericht"),
        
        
        # Seitenleiste
        sidebarLayout(sidebarPanel(
                
                # Auswahl des Laborwertes, der im Plot angezeigt und auch ausgewertet wird
                selectInput(
                        inputId = "y",
                        label = "Bitte Laborwert auswählen",
                        choices = c(
                                "Hämoglobin" = "Hb",
                                "Thrombozyten" = "Thrombozyten",
                                selected = "Hb"
                        )
                )
        ),
        
        
        # Der Output im Mainpanel 
        mainPanel(plotOutput(outputId = "scatterplot")))
)



# Die Serverfunktionen
server <- function(input, output) {
        
        # lädt den Plot bei Auswahl eines Laborwertes
        output$scatterplot <- renderPlot({
                req(input$y)
                ggplot(data = labor,
                       aes_string("Datum", y = input$y)) +
                        geom_line(color = "red") +
                        geom_point(color = "red", size = 4)
        })
}



# die App wird gestartet
shinyApp(ui = ui, server = server)
