class MoviesController < ApplicationController

  # GET: /movies
  get "/movies" do
    protected!
    erb :"/movies/index.html"
  end

  # POST: /movies
  post "/movies" do
    @api=OmdbAPI.new(params["movie"]["title"])
    @api_response = @api.query["Response"]
    if @api_response == "True"
      session[:movies]=[]
      @movies=@api.query["Search"]
      @movies.each do |movie|
        specific_movie = @api.query_specific(movie["Title"])
        # binding.pry
        movie_object = (Movie.find_by(title: specific_movie["Title"]) or Movie.create(title: specific_movie["Title"], release_year: specific_movie["Year"], plot: specific_movie["Plot"], rating: specific_movie["imdbRating"], image_url: specific_movie["Poster"]))
        movie_object.update(title: specific_movie["Title"], release_year: specific_movie["Year"], genre: specific_movie["Genre"], plot: specific_movie["Plot"], rating: specific_movie["imdbRating"], image_url: specific_movie["Poster"])
        session[:movies] << movie_object.id
        session[:movies].uniq!
        session[:movies].compact!
      end
      redirect "/movies/results"
    else
      session[:api_response] = "False"
    end
     redirect "/movies"
  end


  #Search Results
  get "/movies/results" do
    protected!
    erb :"/movies/results.html"
  end

  # GET: /movies/5
  get "/movies/:id" do
    protected!
    @movie = Movie.find(params[:id])
    erb :"/movies/show.html"
  end

end
