require 'rack-flash'

class TripsController < ApplicationController

use Rack::Flash

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
    if params[:trip][:name] == "" || params[:trip][:date] == "" || params[:trip][:destination] == "" || params[:trip][:activities] == ""
      flash[:message] = "Please fill in all fields"
      redirect("/trips/new")
    else
      @trip = current_user.trips.create(params[:trip])
      redirect("/trips/#{@trip.id}")
    end
  end

  get '/trips/:id' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      #binding.pry
      erb :'/trips/show_trip'
    else
      redirect("/login")
    end
  end

  get '/trips/:id/edit' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      if @trip.user_id == current_user.id
        #binding.pry
        erb :'/trips/edit_trip'
      else
        redirect("/trips")
      end
    else
      redirect("/login")
    end
  end

  patch '/trips/:id' do
    @trip = Trip.find_by_id(params[:id])
    if params[:trip][:name] == "" || params[:trip][:date] == "" || params[:trip][:destination] == "" || params[:trip][:activities] == ""
      flash[:message] = "Please fill in all fields"
      redirect("/trips/#{@trip.id}/edit")
    else
      if @trip.user == current_user
        @trip.update(params[:trip])
        redirect("/trips/#{@trip.id}")
      else
        redirect("/trips")
      end
    end
  end

  # params => {trip: {name: "", date: "", destination: ""}}

  get '/trips/:id/delete' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      @trip.delete
      redirect("/trips")
    else
      redirect("/login")
    end
  end

end
