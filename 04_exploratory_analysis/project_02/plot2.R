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
                     "plot2.png",
                     sep = ""),
    width = 480,
    height = 480,
    units = "px",
    bg = "white")

total_emission_by_city_and_year <- tapply(X = nei$Emissions,
                                          INDEX = interaction(nei$fips,
                                                              nei$year),
                                          FUN = sum)
row_ids_of_baltimore <- grep("^24510",
                             names(total_emission_by_city_and_year))
total_emission_baltimore_per_year <- total_emission_by_city_and_year[row_ids_of_baltimore]
#keep only the years from eg.: 24510.1999 --> 1999
names(total_emission_baltimore_per_year) <- substr(names(total_emission_baltimore_per_year),
                                                   7,
                                                   10)
plot(x = names(total_emission_baltimore_per_year),
     y = total_emission_baltimore_per_year,
     ylim = c(0, 4000),
     #      type = "l",
     xlab = "Years",
     ylab = "PM2.5 in tons",
     yaxt = "n",
     xaxt = "n",
     main = "Total emission of PM2.5 in Baltimore City, Maryland\nbetween 1999 and 2008")
at_x <- names(total_emission_baltimore_per_year)
axis(1,
     at = at_x,
     labels = at_x,
     #      vadj = 1,
     cex.axis = 0.8)
at_y <- seq(from = 0,
            to = 4000,
            by = 500)
axis(2,
     at = at_y,
     labels = format(at_y,
                     scientific = FALSE),
     hadj = 0.5,
     cex.axis = 0.8)
grid()

dev.off()