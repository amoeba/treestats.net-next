# frozen_string_literal: true

source "https://rubygems.org"
ruby "2.6.4"

gem "rake"
gem "rack"
gem "sinatra"
gem "sinatra-sequel", git: "https://github.com/amoeba/sinatra-sequel"
gem "sequel-rake"

# Asset management
gem "sprockets"
gem "sprockets-helpers"
gem "sprockets-sass"
gem "sass"
gem "uglifier"
gem "sinatra-asset-pipeline"

group :development do
  gem "sqlite3"
  gem "pry"
end

group :test do
  gem "minitest"
  gem "rack-test"
end

group :development, :test do
  gem "standard"
end

group :production do
  gem "pg"
end
