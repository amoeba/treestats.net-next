# frozen_string_literal: true

require 'sinatra'
require 'sinatra/sequel'

# Database
set :database, 'sqlite://db/treestats.db'

# Models
require_relative 'models/character.rb'
require_relative 'models/skill.rb'
require_relative 'models/title.rb'

# Helpers
require_relative 'helpers/rankings_helper.rb'

# Routes
get "/" do
  @characters = Character.limit(10)

  erb :index
end

get "/servers/?" do  
  erb :servers
end

get "/characters/?" do
  @characters = Character.limit(10)
  
  erb :characters
end

get "/rankings/?" do
  erb :rankings
end

get "/rankings/:ranking" do
  @ranking = params[:ranking]
  @characters = get_ranking(params[:ranking])

  if @characters.nil?
    not_found
  end

  erb :ranking
end

get '/:server' do
  @server = params[:server]
  @characters = Character
    .filter(:server => params[:server])
    .limit(10)

  erb :server
end


get '/:server/:name' do
  @character = Character
    .filter(:name => params[:name], :server => params[:server])
    .first

  erb :character
end
