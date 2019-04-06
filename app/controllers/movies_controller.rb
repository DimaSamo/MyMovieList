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
      session[:movies]=@api.query["Search"]
    else
      session[:api_response] = "False"
      redirect "/movies"
    end
    # binding.pry
     redirect "/movies"
  end

  # GET: /movies/5
  get "/movies/:id" do
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
