### Shiny_Laborkumulativbericht


library(shiny)
library(shinythemes)
library(ggplot2)
library(scales)
library(tidyverse)

# lädt das Laborfile
labor = read.csv(file = "https://raw.githubusercontent.com/dr-xenia/laborbericht/master/labor.csv", header =
                         TRUE, sep = ",")
normwerte = read.csv(file = "https://raw.githubusercontent.com/dr-xenia/laborbericht/master/normwerte.csv", header =
                             TRUE, sep = ";") 
# richtige Formattierung des Datums
labor$Datum <- as.Date(labor$Datum)


# definiert das User Interface
ui <- fluidPage(
        theme = shinytheme("simplex"),
        
        #Titel
        titlePanel("Laborkumulativbericht"),
        
        
        # Seitenleiste
        sidebarLayout(
                sidebarPanel(
                        h3("Menü"),
                        # Auswahl des Laborwertes, der im Plot angezeigt und auch ausgewertet wird
                        selectInput(
                                inputId = "y",
                                label = "Bitte Laborwert auswählen",
                                choices = c(
                                        "Hämoglobin" = "Hb",
                                        "Thrombozyten" = "Thrombozyten",
                                        selected = "Hb"
                                )
                        ),
                        
                        selectInput(
                                inputId = "startdatum",
                                label = "Bitte Startdatum auswählen",
                                choices = c(labor$Datum),
                                selected = labor$Datum[1]
                        ),
                        
                        selectInput(
                                inputId = "enddatum",
                                label = "Bitte Enddatum auswählen",
                                choices = c(labor$Datum),
                                selected = tail(labor$Datum)
                        ),
                        
                        
                        checkboxInput(
                                inputId = "analyse",
                                label = "Automatische Analyse des gewählten Laborwertes",
                                value = FALSE
                        )
                        
                        
                ),
                
                
                # Der Output im Mainpanel
                mainPanel(
                        # zeigt die Laborgrafik an
                        wellPanel(
                                h3("Verlaufsgrafik der Laborwerte"),
                                plotOutput(outputId = "scatterplot"),
                                textOutput(outputId="normwert_text")
                        ),
                        
 
                        
                        # optionale automatische Analyse der Laborwerte
                        conditionalPanel(condition = "input.analyse == true", 
                                         h3("Automatische Analyse"), 
                                         br(), 
                                         p("Viel zu hoch"),
                                         br(),
                                         textOutput(outputId = "normwerte"))
                        
                )
        )
)



# Die Serverfunktionen
server <- function(input, output) {

        # lädt den Plot bei Auswahl eines Laborwertes
         labor_auswahl<-reactive({
           subset(labor, Datum>=input$startdatum & Datum<=input$enddatum)
          })
         
         min<- reactive({
                        subset(normwerte, Values == "min_mann")[,input$y]
         })
         
         max<- reactive({
                 subset(normwerte, Values == "max_mann")[,input$y]
         })

         
        output$scatterplot <- 
                renderPlot({
                req(input$y)
                validate(need(input$enddatum > input$startdatum, "Bitte späteres Enddatum oder früheres Startdatum wählen"))
                ggplot(data = labor_auswahl(),
                       aes_string("Datum", y = input$y))+
                geom_line(color = "red") +
                geom_point(color = "red", size = 4)
        })
        
       
        
        output$normwert_text<- renderText({
                req(input$y)
                paste("Die Werte von", input$y, "sollen zwischen", min(), "und", max(), "liegen.")
                      })
                
        


        
}


# die App wird gestartet
shinyApp(ui = ui, server = server)
