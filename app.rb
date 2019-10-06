# frozen_string_literal: true

require "sinatra"
require "sinatra/sequel"

set :database, ENV["DATABASE_URL"] || "sqlite://db/treestats.db"
Dir[__dir__ + "/models/*"].each { |f| require f }
Dir[__dir__ + "/helpers/*"].each { |f| require f }

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
    .select(:server, :name, :allegiance_name, :followers, :rank, :heritage_id,
      :gender_id)

  erb :index
end

get "/search/?" do
  # Sanitize input first
  @query = params[:query].gsub(/[^a-zA-Z'\-\+ ]/, "")

  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {query: @query, page: @page - 1}
  @next = {query: @query, page: @page + 1}

  query = Character
    .where(Sequel.lit("lower(name) LIKE ?", "%#{@query.downcase}%"))
    .offset(offset)
    .select(:name, :server)
    .order(:name)
    .exclude(level: nil)

  @count = query.count
  @more = @count > @page * limit
  @characters = query.limit(limit)

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

  query = Character
    .offset(offset)
    .select(:server, :name)
    .order(:updated_at)
    .exclude(level: nil)

  @count = query.count
  @more = @count > @page * limit
  @characters = query
    .limit(limit)

  erb :characters
end

get "/rankings/?" do
  erb :rankings
end

get "/rankings/:ranking/?" do
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

  query = Character
    .select(:server, :allegiance_name)
    .distinct
    .order(:allegiance_name)
    .offset(offset)
    .exclude(allegiance_name: nil)

  @count = query.count
  @more = @count > @page * limit
  @allegiances = query.limit(limit)

  not_found if @count <= 0

  erb :allegiances
end

get "/allegiances/:server/?" do |server|
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  query = Character
    .select(:server, :allegiance_name)
    .distinct
    .filter(server: server)
    .order(:allegiance_name)
    .offset(offset)
    .exclude(allegiance_name: nil)

  @count = query.count

  not_found if @count <= 0

  @more = @count > @page * limit
  @allegiances = query
    .limit(limit)

  erb :allegiances
end

get "/allegiances/:server/:allegiance/?" do |server, allegiance|
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  @header = "Allegiance: #{allegiance} (#{server})"
  query = Character
    .select(:server, :name)
    .where(server: server, allegiance_name: allegiance)
    .order(:name)
    .offset(offset)
    .exclude(level: nil)

  @count = query.count

  not_found if @count <= 0

  @more = @count > @page * limit
  @characters = query.limit(limit)

  erb :characters
end

get "/titles/:title_id/?" do
  title_id = params[:title_id].to_i

  if title_id.to_s != params[:title_id]
    status 400
    return "Invalid title number"
  end

  not_found unless title_id.between?(0, 894)

  @page = get_page(params)
  limit = 1
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  @title = title(title_id)
  query = Title
    .filter(title_id: title_id)
    .association_join(:character)
    .select(:server, :name)
    .offset(offset)

  @count = query.count
  @more = @count > @page * limit
  @characters = query.limit(limit)

  erb :title
end

get "/titles/?" do
  @titles = titles

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

get "/:server/?" do
  @page = get_page(params)
  limit = 25
  offset = (@page - 1) * limit

  @prev = {page: @page - 1}
  @next = {page: @page + 1}

  @header = @server
  query = Character
    .filter(server: params[:server])
    .select(:server, :name)
    .order(:updated_at)
    .offset(offset)
    .exclude(level: nil)

  @count = query.count
  @more = @count > @page * limit

  not_found if @count <= 0

  @characters = query
    .limit(limit)

  erb :characters
end

get "/:server/:name/chain.json" do
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
  content_type :json

  @character = Character
    .filter(name: params[:name], server: params[:server])
    .first

  halt(404, "{ \"error\": \"Character not found.\"}") if @character.nil?

  @character.to_json
end

get "/:server/:name/?" do
  @character = Character
    .filter(name: params[:name], server: params[:server])
    .first

  halt(404, "Character not found.") if @character.nil?

  # Return early if this is a stub character
  return erb :character if @character[:strength_base].nil?

  @skills = {
    specialized: @character.skills
      .filter { |s| s.training_id == Sinatra::SkillHelper::TRAINING_ID[:specialized] }
      .sort_by { |s| skill_name(s[:skill_id]) },
    trained: @character.skills
      .filter { |s| s.training_id == Sinatra::SkillHelper::TRAINING_ID[:trained] }
      .sort_by { |s| skill_name(s[:skill_id]) },
    untrained: @character.skills
      .filter { |s| s.training_id == Sinatra::SkillHelper::TRAINING_ID[:untrained] }
      .sort_by { |s| skill_name(s[:skill_id]) },
    unusable: @character.skills
      .filter { |s| s.training_id == Sinatra::SkillHelper::TRAINING_ID[:unusable] }
      .sort_by { |s| skill_name(s[:skill_id]) },
  }

  @titles = @character.titles.sort_by { |t| t.title_id }
  @properties = get_properties(@character.properties)

  erb :character
end
