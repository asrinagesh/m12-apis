# Install and load the jsonlite package
library(jsonlite)
library(httr)

# Make a variable base.url that has the same base url from the omdb documentation.
# (Hint: visit https://www.omdbapi.com/ to find the base url)
base.url <- "http://www.omdbapi.com/?"

# Make a variable called movie that has the name of your favorite movie
move.title <- "Office Space"

# Make a variable called "query.parameters" that holds a list of the parameters
# to pass to the API. View the OMDb documentation to see which parameters
# are available.
query.parameters <- list(t=movie, r='json')

# Make a variable called request that is a string of a request URL made up of the base URL
# and the parameters string
response <- GET(base.url, query = query.parameters)
json.text <- content(response, "text")

# Use fromJSON to retrieve JSON data from the omdb api using your request.
# Store the result in a variable called movie.data
movie.data <- fromJSON(json.text)

# Make movie_data into a data frame using as.data.frame
movie_.data <- as.data.frame(movie.data)

# Write a function called Director that accepts a data frame of movie info and returns
# A vector of strings that states a movie and the director of said movie.
Director <- function(movie.info) {
  result <- paste(movie.info$Title, "directed by", movie.info$Director)
  return (result)
}
# Call Director with your favorite movie, and assign it to the variable movie.director
Director(move.title)

# Bonus #

# Knowing the director of on movie is okay, but it'd be great to know the directors of different
# movies. 

# Start by making a vecotr of movies and save it to the variable movie.list
movie.list <- c("Office Space", "Harry Potter", "Hitchhikers Guide to the Galaxy", "Batman")

# Write a function to make your API request and process the data
MakeRequest <- function(movie.title) {
  query.parameters <- list(t= movie.title, r="json")
  
  # Make a variable called request that is a string of a request URL made up of the base URL
  # and the parameters string
  response <- GET(base.url, query = query.parameters)
  text <- content(response, "text")
  movie.data <- as.data.frame(fromJSON(text))
  return(movie.data)
}

# For every entry in the vector api.request, APPLY the function fromJSON to make a list of lists
# one entry for each request and assign this to a variable called data. 
# (Hint: ?lapply. It's similar a 'for' loop but better!)
data <- lapply(movie.list, MakeRequest)



