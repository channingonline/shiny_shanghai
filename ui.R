
## 导入数据

data <- read.csv('/Users/yequanwei/R/shanghai_shiny/data_shanghai.csv')
district <-  unique(data$区)

# test

library(shiny)
library(leaflet)
library(RColorBrewer)


data <- as_tibble(data)
data$日期 <- as.Date(data$日期)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                selectizeInput('district', '区域', district),
                dateInput('date', label = '日期', min = '2022-03-18', max = max(data$日期), value =max(data$日期) )
  ),
  
)