class UserMoviesController < ApplicationController

  # GET: /user_movies
  get "/user_movies" do
    erb :"/user_movies/index.html"
  end

  #add movie to list
  post "/user_movies/new/:id" do
    @user_movie = UserMovie.new(user_id: current_user.id, movie_id: params[:id])
    @user_movie.save if !UserMovie.find_by(user_id: current_user.id, movie_id: params[:id])
    redirect "/"
  end

  # GET: /user_movies/new
  get "/user_movies/new" do
    erb :"/user_movies/new.html"
  end

  # POST: /user_movies
  post "/user_movies" do
    redirect "/user_movies"
  end

  # GET: /user_movies/5
  get "/user_movies/:user_id/:movie_id" do
    @movie = Movie.find(params[:movie_id])
    @user = User.find(params[:user_id])
    @user_movie = UserMovie.find_by(user_id: @user.id, movie_id: @movie.id)
    erb :"/user_movies/show.html"
  end

  # GET: /user_movies/5/edit
  get "/user_movies/:user_id/:movie_id/edit" do
    @movie = Movie.find(params[:movie_id])
    @user = User.find(params[:user_id])
    @user_movie = UserMovie.find_by(user_id: params[:user_id], movie_id: params[:movie_id])
    erb :"/user_movies/edit.html"
  end

  # PATCH: /user_movies/5
  patch "/user_movies/:user_id/:movie_id" do
    @user_movie = UserMovie.find_by(user_id: params[:user_id], movie_id: params[:movie_id])
    @user_movie.update(params[:user_movie])
    redirect "/user_movies/#{@user_movie.user_id}/#{@user_movie.movie_id}"
  end

  # DELETE: /user_movies/5/delete
  delete '/user_movies/:id/delete' do
    @user_movie = UserMovie.find_by(user_id: current_user.id, movie_id: params[:id])
    @user_movie.delete
    redirect "/"
  end
end
