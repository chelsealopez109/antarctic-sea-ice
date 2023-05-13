library(plotly)

ingest.ice.data <- function(date){
  x <- read.csv(url(paste0("https://polarwatch.noaa.gov/erddap/griddap/nsidcG02202v4sh1day.csv?cdr_seaice_conc%5B(",date,"T00:00:00Z):1:(",date,"T00:00:00Z)%5D%5B(3212500.0):1:(162500.0)%5D%5B(-2887500.0):1:(62500.0)%5D")))[-1,]
  x <- x[x$cdr_seaice_conc != 2.53,] #remove artifact
  x <- x[complete.cases(x),] # remove empty rows
  print(mean(x[,4])) #prints mean ice concentration for that day in the defined region
}

df <- data.frame()
d <- 2
j <- 0
i <- 1
r <- 2
df[1,1] <- "2022-12-01"
repeat{
  df[r,1] <- paste0("2022-12-",as.character(j),as.character(d))
  d = d + 1
  r = r + 1
  if (d > 9){
    j = j + 1
    d <- 0
  }
  if (j == 3){
    df[r,1] <- "2022-12-30"
    rm(d,i,j,r)
    break
  }
}


for (i in 1:nrow(df)){
  df[i,2] <- round(ingest.ice.data(df[i,1]),3)*100
}

colnames(df) <- c("date","average_percent")
df[,1]<-lubridate::ymd(df$date)



p <- plot_ly(data = df, x = ~date, y = ~average_percent, mode = "lines", type = "scatter", 
             #we name the first line (sunrise) and edit the info for the mousover and change
             #the color and "thickness" of the line
             name = "%", line=list(width=5, color = "#ffca7c"))