require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "mymovielist"
    set :method_override, true
  end

  get "/" do
    erb :homepage
  end

  # post "/login" do
  #   binding.pry
  # end

  post "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end

    def protected!
      return if logged_in?
      redirect '/'
    end
  end

end
