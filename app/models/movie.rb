class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  has_many :user_movies
  has_many :users, through: :user_movies

  def self.iterate(movies_array, apiObject, session_hash)
    movies_array.each do |movie|
      specific_movie = apiObject.query_specific(movie["Title"])
      # binding.pry
      movie_object = (Movie.find_by(title: specific_movie["Title"]) or Movie.create(title: specific_movie["Title"], release_year: specific_movie["Year"], plot: specific_movie["Plot"], rating: specific_movie["imdbRating"], image_url: specific_movie["Poster"]))
      movie_object.update(title: specific_movie["Title"], release_year: specific_movie["Year"], genre: specific_movie["Genre"], plot: specific_movie["Plot"], rating: specific_movie["imdbRating"], image_url: specific_movie["Poster"])
      session_hash[:movies] << movie_object.id
      session_hash[:movies].uniq!
      session_hash[:movies].compact!
    end
  end

end
