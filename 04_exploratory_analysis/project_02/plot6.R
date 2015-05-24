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
                     "plot6.png",
                     sep = ""),
    width = 480,
    height = 480,
    units = "px",
    bg = "white")

motor_vehicle_ids <- grepl("*[V|v]ehicle*",
                           scc$EI.Sector)
motor_vehicle_sccs <- scc$SCC[motor_vehicle_ids]
motor_vehicle_df <- nei[(nei$SCC %in% as.character(motor_vehicle_sccs)
                         & (nei$fips == "24510" | nei$fips == "06037")), ]
emission_per_year <- tapply(X = motor_vehicle_df$Emissions,
                            INDEX = interaction(motor_vehicle_df$fips,
                                                motor_vehicle_df$year),
                            FUN = sum)
df <- as.data.frame(emission_per_year)
names(df) <- "emission"
df$fips <- t(as.data.frame(strsplit(x = rownames(df), split = "\\.")))[, 1]
df$city[df$fips == "24510"] <- "Baltimore City"
df$city[df$fips == "06037"] <- "Los Angeles"
df$year <- t(as.data.frame(strsplit(x = rownames(df), split = "\\.")))[, 2]
g <- ggplot(df,
            aes(year,
                emission))
p <- (g
      + geom_point(aes(color = city))
      + ggtitle("PM2.5 emission from vehicles\nbetween 1999 and 2008")
      + labs(x = "Year", y = "Emission in tons"))
print(p)

dev.off()