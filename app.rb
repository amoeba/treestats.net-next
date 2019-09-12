# frozen_string_literal: true

require "sinatra"
require "sinatra/sequel"

# Database
set :database, ENV["DATABASE_URL"] || "sqlite://db/treestats.db"

# Models
require_relative "models/character.rb"
require_relative "models/skill.rb"
require_relative "models/title.rb"
require_relative "models/property.rb"

# Helpers
require_relative "helpers/app_helper.rb"
require_relative "helpers/rankings_helper.rb"
require_relative "helpers/query_helper.rb"
require_relative "helpers/enum_helper.rb"

# Routes
get "/" do
  erb :index
end

get "/search" do
  # Sanitize input first
  @query = params[:query].gsub(/[^a-zA-Z'\-\+ ]/, "")

  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = { :query => @query, :page => @page - 1 }
  @next = { :query => @query, :page => @page + 1 }

  @characters = Character
    .where(Sequel.lit("name LIKE ?", "%#{@query}%"))
    .limit(limit)
    .offset(offset)
    .select(:name, :server)
    .order(:name)

  erb :search
end

get "/servers/?" do
  erb :servers
end

get "/characters/?" do
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = { :page => @page - 1 }
  @next = { :page => @page + 1 }

  @characters = Character
    .limit(limit)
    .offset(offset)
    .select(:server, :name)
    .order(:updated_at)
    .reverse

  @count = @characters.count

  erb :characters
end

get "/rankings/?" do
  erb :rankings
end

get "/rankings/:ranking" do
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = { :page => @page - 1 }
  @next = { :page => @page + 1 }

  params[:page] = @page
  params[:offset] = offset
  params[:limit] = limit

  @characters = get_ranking(params)
  @value_col = value_col(params[:ranking].to_sym)
  @ranking_name = params[:ranking].split("_").map { |w| w.capitalize }.join(" ")

  if @characters.nil?
    not_found
  end

  erb :ranking
end

get "/:server" do
  @server = params[:server]
  @characters = Character
    .filter(server: params[:server])
    .select(:server, :name)
    .order(:updated_at)
    .reverse
    .limit(25)

  erb :server
end

get "/:server/:name/chain" do
  content_type :json

  # TODO: Validate server name
  # TODO: Write validator for char names
  name = params[:name].gsub(/[^a-zA-Z'\-\+ ]/, "")
  server = params[:server]

  character = Character
    .filter(server: server, name: name)
    .first

  if character.nil?
    message = {
      errors: [
        {
          status: 404,
          title: "Character not found.",
          description: "The character #{server}/#{name} could not be found.",
        },
      ],
    }

    halt(404, JSON.pretty_generate(message))
  end

  ultimate = ultimate_patron(character.id)
  chain(ultimate).to_json
end

get "/:server/:name" do
  @character = Character
    .filter(name: params[:name], server: params[:server])
    .first

  @skills = {
    :specialized => @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:specialized] }
      .sort_by { |s| skill(s[:skill_id])
    },
    :trained => @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:trained] }
      .sort_by { |s| skill(s[:skill_id])
    },
    :untrained => @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:untrained] }
      .sort_by { |s| skill(s[:skill_id])
    },
    :unusable => @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:unusable] }
      .sort_by { |s| skill(s[:skill_id])
    }
  }

  @titles = @character.titles.sort_by { |t| t.title_id }

  erb :character
end
