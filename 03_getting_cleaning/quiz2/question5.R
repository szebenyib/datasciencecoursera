setwd("/home/szebenyib/getting_cleaning/quiz2")
filename <- "wksst8110.for"
if (!file.exists(filename)) {
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
                destfile=filename,
                method="curl")
}
df <- read.fwf(file="wksst8110.for",
               widths = c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3),
               skip = 4)
head(df)
