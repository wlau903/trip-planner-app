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

  get '/trips/:id' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      erb :'/trips/show_trip'
    else
      redirect("/login")
    end
  end

  get '/trips/:id/edit' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      if @trip.user_id == current_user.id
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
    if params[:name] == "" || params[:date] == "" || params[:destination] == "" || params[:activities] == ""
      redirect("/trips/#{@trip.id}/edit")
    else
      @trip.update(name: params[:name], date: params[:date], destination: params[:destination], activities: params[:activities])
      @trip.user_id = current_user.id
      @trip.save
      redirect("/trips/#{@trip.id}")
    end
  end

end
