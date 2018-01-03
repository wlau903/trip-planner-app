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

  post '/trips' do
    if params[:name] == "" || params[:date] == "" || params[:destination] == "" || params[:activities] == ""
      redirect("/trips/new")
    else
      @trip = current_user.trips.create(name: params[:name], date: params[:date], destination: params[:destination], activities: params[:activities])
      @trip.save
      redirect("/trips/#{@trip.id}")
    end
  end

end
