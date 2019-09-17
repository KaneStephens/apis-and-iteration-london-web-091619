require 'rest-client'
require 'json'
require 'pry'

def get_api_hash(link)
  response_string = RestClient.get(link)
  return JSON.parse(response_string)
end

def get_film_names(film, array)
  film_hash = get_api_hash(film)
  film_title = film_hash["title"]
  array.push(film_title)
end

def get_character_movies_from_api(character_name)

  response_hash = get_api_hash('http://www.swapi.co/api/people/')
  
  character_film_name_array = []

  character_array = response_hash["results"]
  character_array.each { |character|
    if character["name"].downcase == character_name then
      character_films_array = character["films"]
      character_films_array.each { |film|
        get_film_names(film, character_film_name_array)
        }
    end
  }

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
