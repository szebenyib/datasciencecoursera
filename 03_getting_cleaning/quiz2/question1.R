library(httr)

oauth_endpoints("github")
myapp <- oauth_app(appname= "github",
                   key = "bb2796fcd45e13cae251",
                   secret = "e0cec9baeee4dd3ec3921a73d01da5dfbb40ed3f")
github_token <- oauth2.0_token(endpoint = oauth_endpoints("github"),
                               app = myapp,
                               cache = FALSE)
#Needed below?
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

data1 <- fromJSON("https://api.github.com/users/jtleek/repos")
#data1$name=="datasharing"
names_of_repos <- data1$name
id <- 0
for (i in 1:length(names_of_repos)) {
  if(names_of_repos[i] == "datasharing"){
    id <- i
  }
}

print(data1$created_at[id])