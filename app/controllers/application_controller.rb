require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "mymovielist"
    set :method_override, true
    register Sinatra::Flash
  end

  get "/" do
    if !logged_in?
      redirect "/login"
    end
    erb :homepage
  end


  post "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||=  User.find_by_id(session[:user_id])
    end

    def protected!
      return if logged_in?
      redirect '/'
    end
  end

end
