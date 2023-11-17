require 'open-uri'
require 'json'

# Replace the API endpoint with the provided proxy URL
api_url = 'http://tmdb.lewagon.com/3/movie/top_rated'

# Fetch data from the API
response = URI.open(api_url).read
movies_data = JSON.parse(response)['results']

# Seed genres if not already present
["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
  MovieGenre.find_or_create_by!(name: genre_name)
end

# Seed movies in the database
movies_data.each do |movie_data|
  movie = Movie.find_or_initialize_by(title: movie_data['title'])

  movie.update!(
    overview: movie_data['overview'],
    release_date: movie_data['release_date'],
    # Add other attributes as needed
  )

  # Associate the movie with a random genre
  genre = MovieGenre.find_by(name: "Action") # You may need to adjust this based on the actual genre name
  movie_genre = genre || MovieGenre.first
  movie.movie_genres << movie_genre

  movie.save!
end

puts 'Movies and genres seeded successfully!'
