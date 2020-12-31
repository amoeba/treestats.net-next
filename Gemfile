# frozen_string_literal: true

source "https://rubygems.org"
ruby "3.0.0"

gem "rake"
gem "rack", ">= 2.0.8"
gem "sinatra"
gem "sinatra-sequel", git: "https://github.com/amoeba/sinatra-sequel"
gem "sequel-rake"
gem "puma"

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
  gem "skylight"
end

# Ensure this is required down low
gem "rack-mini-profiler"

# For memory profiling
gem "memory_profiler"

# For call-stack profiling flamegraphs
gem "flamegraph"
gem "stackprof"
