class TripsController < ApplicationController

  get '/trips' do
    if logged_in?
      @trips = Trip.all
      #show randomized trips from users?
      erb :'/trips/trips'
    else
      redirect("/login")
    end
  end

  get '/trips/new' do
    if logged_in?
      erb :'/trips/create_trip'
    else
      redirect("/login")
    end
  end

end
