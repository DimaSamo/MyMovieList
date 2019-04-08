require 'pry'
class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/signup" do
    @invalid=params[:invalid]
    erb :"/users/new.html"
  end

  get "/login" do
    @invalid=params[:invalid]
    erb :"/users/login.html"
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  # POST: /users
  post "/signup" do
    @user = User.new(params["user"])
    if @user.save
      @user.update(user_name: @user.user_name.downcase)
      session[:user_id] = @user.id
      redirect "/"
    else
      redirect "/signup?invalid=true"
    end
  end

  post "/login" do
    @user = User.find_by(user_name: params[:user_name].downcase)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect "/login?invalid=true"
  end

  # GET: /users/5
  get "/users/:id" do
    protected!
    @user = User.find(params[:id])
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    protected!
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
      erb :"/users/edit.html"
    else
      redirect "/"
    end
  end

#  Login Failure Page
  get "/signup/failure" do
    erb :"/users/failure.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    @user = User.find(params[:id])
    @user.update(params[:user])
    binding.pry
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
