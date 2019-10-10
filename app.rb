# frozen_string_literal: true

require "bundler"
Bundler.require
require "sinatra/asset_pipeline"

# Set up a global DB variable so models can load
DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite://db/treestats.db")

Dir[__dir__ + "/models/*"].each { |f| require f }
Dir[__dir__ + "/helpers/*"].each { |f| require f }

class App < Sinatra::Base
  # Database
  set :database, ENV["DATABASE_URL"] || "sqlite://db/treestats.db"

  # Assets
  register Sinatra::AssetPipeline
  set :assets_precompile, %w[*.js *.scss *.png]
  set :assets_js_compressor, Uglifier.new(harmony: true)
  set :assets_css_compressor, :scss

  helpers do
    include Sprockets::Helpers

    include Sinatra::AppHelper
    include Sinatra::GenderHelper
    include Sinatra::HeritageHelper
    include Sinatra::MasteryHelper
    include Sinatra::PropertyHelper
    include Sinatra::QueryHelper
    include Sinatra::RankHelper
    include Sinatra::RankingHelper
    include Sinatra::SkillHelper
    include Sinatra::SocietyHelper
    include Sinatra::TitleHelper
  end

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
      .exclude(allegiance_name: nil)
      .select(:server, :name, :allegiance_name, :followers, :rank, :heritage_id,
        :gender_id)

    erb :index
  end

  get "/search/?" do
    # Sanitize input first
    @query = params[:query].gsub(/[^a-zA-Z'\-\+ ]/, "")

    query = Character
      .where(Sequel.lit("lower(name) LIKE ?", "%#{@query.downcase}%"))
      .select(:name, :server)
      .order(:name)
      .exclude(level: nil)

    @page_params = get_page_params(params, query.count)
    @characters = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

    erb :search
  end

  get "/servers.json" do
    content_type :json

    servers.to_json
  end

  get "/servers/?" do
    erb :servers
  end

  get "/characters/?" do
    query = Character
      .select(:server, :name)
      .order(:updated_at)
      .exclude(level: nil)

    @page_params = get_page_params(params, query.count)
    @characters = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

    erb :characters
  end

  get "/rankings/?" do
    erb :rankings
  end

  get "/rankings/:ranking/?" do |ranking|
    query = get_ranking(params)

    @page_params = get_page_params(params, query.count)
    @value_col = value_col(ranking.to_sym)
    @ranking_name = ranking.split("_").map { |w| w.capitalize }.join(" ")
    @characters = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

    erb :ranking
  end

  get "/allegiances/?" do
    query = Character
      .select(:server, :allegiance_name)
      .distinct
      .order(:allegiance_name)
      .exclude(allegiance_name: nil)

    @page_params = get_page_params(params, query.count)
    @allegiances = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

    erb :allegiances
  end

  get "/allegiances/:server/?" do |server|
    not_found unless servers.include?(server)

    query = Character
      .select(:server, :allegiance_name)
      .distinct
      .filter(server: server)
      .order(:allegiance_name)
      .exclude(allegiance_name: nil)

    @page_params = get_page_params(params, query.count)
    @allegiances = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

    erb :allegiances
  end

  get "/allegiances/:server/:allegiance/?" do |server, allegiance|
    query = Character
      .select(:server, :name)
      .where(server: server, allegiance_name: allegiance)
      .order(:name)
      .exclude(level: nil)

    @header = "Allegiance: #{allegiance} (#{server})"
    @page_params = get_page_params(params, query.count)
    @characters = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

    erb :characters
  end

  get "/titles/:title_id/?" do |title_id|
    title_id = title_id.to_i

    if title_id.to_s != params[:title_id]
      status 400
      return "Invalid title number"
    end

    not_found unless title_id.between?(0, 894)

    @title = title(title_id)
    query = Title
      .filter(title_id: title_id)
      .association_join(:character)
      .select(:server, :name)

    @page_params = get_page_params(params, query.count)
    @characters = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

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

  get "/:server/?" do |server|
    not_found unless servers.include?(server)

    query = Character
      .filter(server: server)
      .select(:server, :name)
      .order(:updated_at)
      .exclude(level: nil)

    @header = server
    @page_params = get_page_params(params, query.count)
    @characters = query
      .limit(@page_params[:limit])
      .offset(@page_params[:offset])

    erb :characters
  end

  get "/:server/:name/chain.json" do |server, name|
    content_type :json

    # TODO: Validate server name
    # TODO: Write validator for char names
    name = name.gsub(/[^a-zA-Z'\-\+ ]/, "")

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

  get "/:server/:name.json" do |server, name|
    content_type :json

    @character = Character
      .filter(name: name, server: server)
      .first

    halt(404, "{ \"error\": \"Character not found.\"}") if @character.nil?

    @character.to_json
  end

  get "/:server/:name/?" do |server, name|
    @character = Character
      .filter(name: name, server: server)
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
end
