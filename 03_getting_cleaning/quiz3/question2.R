setwd("/home/szebenyib/getting_cleaning/quiz3")
filename <- "getdata_jeff.jpg"
if (!file.exists(filename)) {
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
                destfile=filename,
                method="curl")
}
library(jpeg)

pic <- readJPEG(source = filename,
                native = TRUE)

splitted_to_list <- split(x = pic,
                          f = col(pic))

unlisted <- unlist(splitted_to_list)

quantiles <- quantile(x = unlisted,probs = c(0.3, 0.8))

print(quantiles)
