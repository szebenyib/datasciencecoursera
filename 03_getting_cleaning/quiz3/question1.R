setwd("/home/szebenyib/getting_cleaning/quiz3")
filename <- "getdata_data_ss06hid.csv"
if (!file.exists(filename)) {
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                destfile=filename,
                method="curl")
}

df <- read.csv(filename)

agricultureLogical <- df$ACR == 3 & df$AGS == 6

print(which(agricultureLogical))