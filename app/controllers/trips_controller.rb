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

  
end
