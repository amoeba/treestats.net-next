# frozen_string_literal: true

source "https://rubygems.org"

gem "sinatra"
gem "sinatra-sequel", :git => "https://github.com/amoeba/sinatra-sequel"
gem "sequel-rake"

group :production do
  gem "pg"
end

group :development do
  gem "sqlite3"
end
