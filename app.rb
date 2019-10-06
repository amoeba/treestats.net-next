# frozen_string_literal: true

require "sinatra"
require "sinatra/sequel"

set :database, ENV["DATABASE_URL"] || "sqlite://db/treestats.db"
Dir[__dir__ + "/models/*"].each &method(:require)
Dir[__dir__ + "/helpers/*"].each &method(:require)

# Routes
get "/" do
  @recent = Character
    .select(:name, :server)
    .exclude(level: nil)
    .order(:updated_at)
    .limit(10)

  @chars_per_server = Character
    .group_and_count(:server)
    .order(:count)
    .reverse

  @top_monarchs = Character
    .filter(patron_id: nil)
    .select(:server,
            :name,
            :allegiance_name,
            :followers,
            :rank,
            :race_id,
            :gender_id)

  erb :index
end

get "/search" do
  # Sanitize input first
  @query = params[:query].gsub(/[^a-zA-Z'\-\+ ]/, "")

  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {query: @query, page: @page - 1}
  @next = {query: @query, page: @page + 1}

  @characters = Character
    .where(Sequel.lit("lower(name) LIKE ?", "%#{@query.downcase}%"))
    .limit(limit)
    .offset(offset)
    .select(:name, :server)
    .order(:name)
    .exclude(level: nil)

  erb :search
end

get "/servers/?" do
  erb :servers
end

get "/characters/?" do
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  @characters = Character
    .limit(limit)
    .offset(offset)
    .select(:server, :name)
    .order(:updated_at)
    .exclude(level: nil)

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

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  params[:page] = @page
  params[:offset] = offset
  params[:limit] = limit

  @characters = get_ranking(params)
  @value_col = value_col(params[:ranking].to_sym)
  @ranking_name = params[:ranking].split("_").map { |w| w.capitalize }.join(" ")

  not_found if @characters.nil?

  erb :ranking
end

get "/allegiances/?" do
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  params[:page] = @page
  params[:offset] = offset
  params[:limit] = limit

  @allegiances = Character
    .distinct
    .select(:server, :allegiance_name)
    .order(:allegiance_name)
    .limit(limit)
    .offset(offset)
    .exclude(allegiance_name: nil)

  not_found if @allegiances.nil?

  erb :allegiances
end

get "/allegiances/:server" do |server|
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  params[:page] = @page
  params[:offset] = offset
  params[:limit] = limit

  @characters = Character
    .distinct
    .select(:server, :allegiance_name)
    .where(server: server)
    .order(:allegiance_name)
    .limit(limit)
    .offset(offset)

  not_found if @characters.nil?

  erb :characters
end

get "/allegiances/:server/:allegiance" do |server, allegiance|
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  params[:page] = @page
  params[:offset] = offset
  params[:limit] = limit

  @header = "Allegiance: #{allegiance} (#{server})"
  @characters = Character
    .select(:server, :name)
    .where(server: server, allegiance_name: allegiance)
    .order(:name)
    .limit(limit)
    .offset(offset)
    .exclude(level: nil)

  not_found if @characters.nil?

  erb :characters
end

get "/titles/?" do
  erb :titles
end

get "/populations.json" do
  content_type :json

  populations.to_json
end

get "/populations/?" do
  @populations = populations

  erb :populations
end

get "/download/?" do
  erb :download
end

get "/api/?" do
  erb :api
end

get "/:server" do
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  @header = @server
  @characters = Character
    .filter(server: params[:server])
    .select(:server, :name)
    .order(:updated_at)
    .offset(offset)
    .limit(limit)
    .exclude(level: nil)

  erb :characters
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

get "/:server/:name.json" do
  @character = Character
    .filter(name: params[:name], server: params[:server])
    .first

  halt(404, "{ \"error\": \"Character not found.\"}") if @character.nil?

  content_type :json
  @character.to_json
end

get "/:server/:name" do
  @character = Character
    .filter(name: params[:name], server: params[:server])
    .first

  halt(404, "Character not found.") if @character.nil?

  # Return early if this is a stub character
  return erb :character if @character[:strength_base].nil?

  @skills = {
    specialized: @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:specialized] }
      .sort_by { |s| skill_name(s[:skill_id]) },
    trained: @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:trained] }
      .sort_by { |s| skill_name(s[:skill_id]) },
    untrained: @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:untrained] }
      .sort_by { |s| skill_name(s[:skill_id]) },
    unusable: @character.skills
      .filter { |s| s.training_id == Sinatra::EnumHelper::TRAINING[:unusable] }
      .sort_by { |s| skill_name(s[:skill_id]) },
  }

  @titles = @character.titles.sort_by { |t| t.title_id }
  @properties = get_properties(@character.properties)

  erb :character
end
