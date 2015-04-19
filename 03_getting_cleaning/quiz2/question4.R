setwd("/home/szebenyib/getting_cleaning/quiz2")
if (!file.exists("contact.html")) {
  download.file(url="http://biostat.jhsph.edu/~jleek/contact.html",
                destfile="contact.html",
                method="curl")
}
raw_html <- readLines(con="contact.html")
for (i in c(10, 20, 30, 100)) {
  print(nchar(raw_html[i]))
}

