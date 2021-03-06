require 'will_paginate'
require 'will_paginate/active_record'

class BikeShareApp < Sinatra::Base
  configure { register WillPaginate::Sinatra }
  set :method_override, true

  get '/' do
    erb :"/dashboard"
  end

  get '/stations/dashboard' do
    erb :"/stations-dashboard"
  end

  get '/stations/index' do
    @stations = Station.paginate(:page => params[:page], :per_page => 30)

    erb :"/stations/index"
  end

  get '/stations/new' do
    erb :"/stations/new"
  end

  get '/stations/:id' do
    @station = Station.find(params[:id])

    erb :"/stations/show"
  end

  post '/stations' do
    station = Station.create(params[:station])

    redirect "/stations/#{station.id}"
  end

  get '/stations/:id/edit' do
    @station = Station.find(params[:id])

    erb :"/stations/edit"
  end

  put '/stations/:id' do |id|
    Station.update(id.to_i, params[:station])

    redirect "/stations/#{id}"
  end

  delete '/stations/:id' do |id|
    Station.destroy(id.to_i)

    redirect "/stations/index"
  end

  get '/trips/dashboard' do
    erb :"/trips-dashboard"
  end

  get '/trips' do
    @trips = Trip.paginate(:page => params[:page], :per_page => 30)

    erb :"/trips/index"
  end

  get '/trips/new' do
    @stations = Station.all
    erb :"/trips/new"
  end

  post '/trips' do
    trip = Trip.create(params[:trip])

    redirect "/trips/#{trip.id}"
  end

  get '/trips/:id' do
    @trip = Trip.find(params[:id])

    erb :"/trips/show"
  end

  get '/trips/:id/edit' do
    @trip = Trip.find(params[:id])
    @stations = Station.all
    erb :"/trips/edit"
  end

  put '/trips/:id' do |id|
    Trip.update(id.to_i, params[:trip])

    redirect "/trips/#{id}"
  end

  delete '/trips/:id' do |id|
    Trip.destroy(id.to_i)

    redirect "/trips"
  end

  get '/conditions/dashboard' do
    erb :"/conditions-dashboard"
  end

  get '/conditions' do
    @conditions = Condition.paginate(:page => params[:page], :per_page => 30)

    erb :"/conditions/index"
  end

  get '/conditions/new' do

    erb :"/conditions/new"
  end

  post '/conditions' do
    condition = Condition.create(params[:condition])

    redirect "/conditions/#{condition.id}"
  end

  get '/conditions/:id' do
    @condition = Condition.find(params[:id])

    erb :"/conditions/show"
  end

  get '/conditions/:id/edit' do
    @condition = Condition.find(params[:id])

    erb :"/conditions/edit"
  end

  put '/conditions/:id' do |id|
    Condition.update(id, params[:condition])
    redirect "/conditions/#{id}"
  end

  delete '/conditions/:id' do |id|
    Condition.destroy(id)

    redirect "/conditions"
  end
end
