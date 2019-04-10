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
      Movie.iterate(@movies, @api, session)
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
