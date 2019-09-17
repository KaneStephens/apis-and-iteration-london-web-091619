require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  character_film_name_array = []

  character_array = response_hash["results"]
  character_array.each { |character|
    if character["name"].downcase == character_name then
      character_films_array = character["films"]
      character_films_array.each { |film|
        film_string = RestClient.get(film)
        film_hash = JSON.parse(film_string)
        film_title = film_hash["title"]
        character_film_name_array.push(film_title)
        }
    end
  }
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`  


  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  return character_film_name_array
end

def print_movies(films)
  counter = 1
  films.each { |film|
    puts "#{counter} #{film} "
    counter += 1
  }
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
