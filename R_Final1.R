library(rvest)
url <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"

my_html <- read_html(url)


my_tables <- html_nodes(my_html,"table")[[1]]
populous_table <- html_table(my_tables)

populous_table <- populous_table[,-4:-6]
populous_table$Population <- as.numeric(gsub(",","",populous_table$Population))/100000

names(populous_table) = c("Rank","Country","Population","Historic Information")



library(lattice)
xyplot(Population ~ as.factor(Country), populous_table[1:50,],
       scales = list(x = c(rot=60)),type="h",main="Most Densely Populated Countries")


populous_table$Rank = ifelse(is.na(populous_table$Rank),ave(populous_table$Rank, 
FUN = function(x) mean(x, na.rm = 'TRUE')),populous_table$Rank)


populous_table$Population <- round(populous_table$Population)


install.packages("glimpse")
library(glimpse)

populous_table$Rank <- as.numeric(format(round(populous_table$Rank,0)))
glimpse(populous_table)


populous_table$Rank <- as.numeric(format(round(populous_table$Rank,0)))


write.csv(populous_table, file = "Book1.csv", row.names = TRUE, sep = ',', col.names = TRUE)


