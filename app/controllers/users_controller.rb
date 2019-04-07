require 'pry'
class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/signup" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/signup" do
    @user = User.new(params["user"])
    if @user.save
      session[:user_id] = @user.id
      redirect "/"
    else
      redirect "/signup/failure"
    end
  end

  post "/login" do
    @user = User.find_by(user_name: params[:user_name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect "/"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

#  Login Failure Page
  get "/signup/failure" do
    erb :"/users/failure.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
