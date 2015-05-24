#All plots are included together in a more coherent form
#in the explo_course_project_2.md. Therefore these source files may include
#code duplicates and that is why there are no comments.

library(knitr) #markdown
library(lattice) #plotting
library(data.table) #big tables
library(stringr) #string_match
library(ggplot2) #ggplot2
library(scales) #ggplot2 scientific notation disabling
library(xtable) #table output

working_dir <- "/home/szebenyib/explo/project_02/"

filename <- "NEI_data.zip"
full_path <- paste(working_dir,
                   filename,
                   sep = "")
if (!file.exists(full_path)) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = full_path, 
                method = "curl")
  unzip(zipfile = full_path,
        exdir = working_dir)
}
nei <- readRDS(file = paste(working_dir,
                            "summarySCC_PM25.rds",
                            sep = ""))
scc <- readRDS(file = paste(working_dir,
                            "Source_Classification_Code.rds",
                            sep = ""))

png(filename = paste(working_dir,
                     "plot3.png",
                     sep = ""),
    width = 480,
    height = 480,
    units = "px",
    bg = "white")

total_emission_by_city_year_type <- tapply(X = nei$Emissions,
                                           INDEX = interaction(nei$fips,
                                                               nei$year,
                                                               nei$type),
                                           FUN = sum)
row_ids_of_baltimore <- grep("^24510",
                             names(total_emission_by_city_year_type))
total_emission_baltimore_per_year_type <- total_emission_by_city_year_type[row_ids_of_baltimore]
df <- as.data.frame(total_emission_baltimore_per_year_type)
names(df)[1] <- "emission"
df$year <- substr(str_match(names(total_emission_baltimore_per_year_type),
                            "\\.([0-9]){4}\\."), 
                  2,
                  5)[ , 1]
names_list_of_rows <-strsplit(names(total_emission_baltimore_per_year_type),
                              "\\.")
col_data <- t(as.data.frame(names_list_of_rows))
df$type <- col_data[ , 3]
names(total_emission_baltimore_per_year_type) <- substr(names(total_emission_baltimore_per_year_type),
                                                        7,
                                                        10)
g <- ggplot(df, aes(year, emission))
p <- (g
      + geom_point(aes(color = type))
      + ggtitle("PM2.5 emission in Baltimore\nbetween 1999 and 2008")
      + labs(x = "Year", y = "Emission in tons"))
print(p)

dev.off()