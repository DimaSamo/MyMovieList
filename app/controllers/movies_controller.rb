class MoviesController < ApplicationController

  # GET: /movies
  get "/movies" do
    erb :"/movies/index.html"
  end

  # GET: /movies/new
  get "/movies/new" do
    erb :"/movies/new.html"
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

  #add movie to list
  post "/add_movie/:id" do
    @user_movie = UserMovie.new(user_id: current_user.id, movie_id: params[:id])
    @user_movie.save if !UserMovie.find_by(user_id: current_user.id, movie_id: params[:id])
    redirect "/"
  end


  #Search Results
  get "/movies/results" do
    erb :"/movies/results.html"
  end

  # GET: /movies/5
  get "/movies/:id" do
    @movie = Movie.find(params[:id])
    erb :"/movies/show.html"
  end

  # GET: /movies/5/edit
  get "/movies/:id/edit" do
    erb :"/movies/edit.html"
  end

  # PATCH: /movies/5
  patch "/movies/:id" do
    redirect "/movies/:id"
  end

  # DELETE: /movies/5/delete
  delete "/movies/:id/delete" do
    redirect "/movies"
  end
end
