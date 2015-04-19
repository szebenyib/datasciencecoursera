setwd("/home/szebenyib/getting_cleaning/quiz2")
if (!file.exists("dlfile.csv")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
                destfile="dlfile.csv",
                method="curl")
}
library(sqldf)
res <- read.csv.sql(file="dlfile.csv",
             sql = "select pwgtp1 from file where AGEP < 50")
