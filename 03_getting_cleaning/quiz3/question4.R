setwd("/home/szebenyib/getting_cleaning/quiz3")

#1
filename <- "getdata_data_GDP.csv"
if (!file.exists(filename)) {
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                destfile=filename,
                method="curl")
}
gdp <- read.csv(file = filename, 
                header = FALSE,
                sep = ",",
                skip = 5,
                nrows = 190,
                na.strings = "NA")

gdp <- gdp[c(1, 2, 4, 5)]

colnames(gdp) <- c("CountryCode",
                   "rank",
                   "name",
                   "econ_in_usd")



#2
filename <- "getdata_data_EDSTATS_Country.csv"
if (!file.exists(filename)) {
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                destfile=filename,
                method="curl")
}
edstat <- read.csv(filename)

df <- merge(x = gdp,
            y = edstat,
            by.x = "CountryCode",
            by.y = "CountryCode",
            all = FALSE)

df <- df[order(df$rank, decreasing = FALSE), ]

b <- df[df$Income.Group == "High income: OECD", ]
c <- df[df$Income.Group == "High income: nonOECD", ]

print(mean(b$rank))
print(mean(c$rank))