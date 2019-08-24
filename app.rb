require 'sinatra'
require 'sinatra/sequel'

set :database, 'sqlite://db/treestats.db'
require_relative "db/database.rb"

get "/" do
  erb :index
end

get "/characters/?" do
  @characters = database[:characters].limit(10)

  erb :characters
end

get '/:server/:name' do
  @character = database[:characters]
    .filter(:name => params[:name], :server => params[:server])
    .first

  @skills = database[:skills]
    .filter(:character_id => @character[:id])

  erb :character
end