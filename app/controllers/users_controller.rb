require 'rack-flash'

class UsersController < ApplicationController

use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect("/trips")
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Please fill in all fields"
      redirect("/signup")
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      #binding.pry
      redirect("/trips")
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect("/trips")
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect("/trips")
    else
      flash[:message] = "Sorry, we couldn't find you. Please try again or create an account"
      redirect("/login")
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    #binding.pry
    erb :'/users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect("/login")
    else
      redirect("/")
    end
  end

end
