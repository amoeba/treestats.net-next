# frozen_string_literal: true

require "date"
require "bundler/setup"
Bundler.require(:default)

require "./etc/import_helper"
require "./etc/tree.rb"

task default: :test

task :test do
  Dir["./test/*_test.rb"].each { |f| load f }
end

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    url = ENV["DATABASE_URL"] || "sqlite://db/treestats.db"

    Sequel.connect(url) do |db|
      Sequel::Migrator.run(db, "db/migrations", target: version)
    end
  end

  task :import do
    desc "Import data from JSON files"

    require "sequel"
    require "json"

    db_uri = ENV["DATABASE_URL"] || "sqlite://db/treestats.db"

    Sequel.connect(db_uri) do |db|
      require_relative "models/character"
      require_relative "models/skill"
      require_relative "models/title"
      require_relative "models/property"
      require_relative "models/account"

      files = Dir.glob("data/*.json")

      if files.length <= 0
        raise("No files found at path #{args[:path]}.")
      end

      files.each do |file|
        contents = File.read(file)

        # Pass one: Add in basic character information
        # Pass two will link monarchs and patrons together
        contents.split("\n").each do |line|
          data = JSON.parse(line)

          puts "#{data["s"]}/#{data["n"]}"

          # Skip if needed
          heritage_id = ImportHelper.heritage_id(data["r"])
          gender_id = ImportHelper.gender_id(data["g"])

          # Skip on nil heritage
          if heritage_id.nil? || gender_id.nil?
            puts "NIL HERITAGE/GENDER: #{data}"
            next
          end

          char = Character.update_or_create(server: data["s"], name: data["n"]) { |char|
            char.server = data["s"]
            char.name = data["n"]
            char.heritage_id = heritage_id
            char.gender_id = gender_id

            rank = data["rn"]

            char.rank = if rank.nil? || rank.zero?
              1
            else
              rank
            end

            char.allegiance_name = data["an"]
            char.created_at = DateTime.parse(data["c_at"]["$date"]).to_time.utc
            char.updated_at = DateTime.parse(data["u_at"]["$date"]).to_time.utc

            if data["a"]
              char.level = data["l"]
              char.deaths = data["d"]

              # Handle nil birth
              if data["b"]
                char.birth = DateTime.parse(data["b"]["$date"]).to_time.utc
              end

              char.followers = data["f"]
              char.strength_creation = data["a"]["strength"]["creation"]
              char.strength_base = data["a"]["strength"]["base"]
              char.endurance_creation = data["a"]["endurance"]["creation"]
              char.endurance_base = data["a"]["endurance"]["base"]
              char.coordination_creation = data["a"]["coordination"]["creation"]
              char.coordination_base = data["a"]["coordination"]["base"]
              char.quickness_creation = data["a"]["quickness"]["creation"]
              char.quickness_base = data["a"]["quickness"]["base"]
              char.focus_creation = data["a"]["focus"]["creation"]
              char.focus_base = data["a"]["focus"]["base"]
              char.self_creation = data["a"]["self"]["creation"]
              char.self_base = data["a"]["self"]["base"]
              char.health_base = data["vi"]["health"]["base"]
              char.stamina_base = data["vi"]["stamina"]["base"]
              char.mana_base = data["vi"]["mana"]["base"]
              char.current_title = data["tc"]

              # Handle case where tx and u are either { "12345" } or { "$numberLong" => 12345 }
              char.total_xp = if data["tx"].is_a?(Hash)
                data["tx"]["$numberLong"].to_i
              else
                data["tx"].to_i
              end

              char.unassigned_xp = if data["u"].is_a?(Hash)
                data["u"]["$numberLong"].to_i
              else
                data["u"].to_i
              end

              char.skill_credits = data["sc"]
              char.luminance_total = data["lt"]
              char.luminance_earned = data["lx"]
            end

            if data["m"]
              monarch = Character.update_or_create(server: data["s"], name: data["m"]["name"]) { |m|
                if m.heritage_id.nil?
                  heritage_id = ImportHelper.heritage_id(data["m"]["race"])
                  m.heritage_id = heritage_id.nil? ? 0 : heritage_id
                end

                if m.gender_id.nil?
                  gender_id = ImportHelper.gender_id(data["m"]["gender"])
                  m.gender_id = gender_id.nil? ? 0 : gender_id
                end

                rank = data["m"]["rank"]

                m.rank = if rank.nil? || rank.zero?
                  1
                else
                  rank
                end

                if m.followers.nil?
                  m.followers = data["m"]["followers"]
                end

                if m.created_at.nil?
                  m.created_at = DateTime.now.to_time.utc
                end

                if m.updated_at.nil?
                  m.updated_at = DateTime.now.to_time.utc
                end
              }

              char.monarch_id = monarch.id
            end

            if data["p"]
              patron = Character.update_or_create(server: data["s"], name: data["p"]["name"]) { |p|
                if p.heritage_id.nil?
                  heritage_id = ImportHelper.heritage_id(data["p"]["race"])
                  p.heritage_id = heritage_id.nil? ? 0 : heritage_id
                end

                if p.gender_id.nil?
                  gender_id = ImportHelper.gender_id(data["p"]["gender"])
                  p.gender_id = gender_id.nil? ? 0 : gender_id
                end

                rank = data["p"]["rank"]

                p.rank = if rank.nil? || rank.zero?
                  1
                else
                  rank
                end

                if p.created_at.nil?
                  p.created_at = DateTime.now.to_time.utc
                end

                if p.updated_at.nil?
                  p.updated_at = DateTime.now.to_time.utc
                end
              }

              char.patron_id = patron.id
            end
          }

          if data["acc"]
            account = Account.update_or_create(name: data["acc"]) { |a|
              a.name = data["acc"]
            }

            char.account_id = account.id
          end

          data["sk"]&.each do |k, v|
            skill_id = ImportHelper.skill_id(v["name"])

            if skill_id.nil?
              puts "Skill ID was nil: #{data}"
              next
            end

            Skill.new(
              character_id: char.id,
              skill_id: skill_id,
              training_id: ImportHelper.training_id(v["training"]),
              base: v["base"]
            ).save
          end

          data["ti"]&.each do |t|
            Title.new(
              character_id: char.id,
              title_id: t
            ).save
          end

          data["pr"]&.each do |k, v|
            Property.new(
              character_id: char.id,
              property_id: k.to_i,
              value: v.to_i
            ).save
          end
        end
      end
    end
  end

  task :import_allegiance do
    desc "Import allegiance from JSON files. Run this after running import task"

    require "sequel"
    require "json"

    db_uri = ENV["DATABASE_URL"] || "sqlite://db/treestats.db"
    Sequel.connect(db_uri) do |db|
      require_relative "models/character"
      require_relative "models/skill"
      require_relative "models/title"
      require_relative "models/property"

      files = Dir.glob("data/*.json")

      if files.length <= 0
        raise("No files found at path #{args[:path]}.")
      end

      files.each do |file|
        contents = File.read(file)

        contents.split("\n").each do |line|
          data = JSON.parse(line)

          if data["p"]
            patron = Character[server: data["s"], name: data["p"]["name"]]

            # heritage_id = ImportHelper::heritage_id(data["m"]["race"])
            # gender_id = ImportHelper::gender_id(data["m"]["gender"])
            # rank = data["m"]["rank"]
            # followers = data["m"]["followers"]

            next unless !patron.nil?

            puts "#{patron.heritage_id}/#{data["p"]["race"]}"
          end
        end
      end
    end
  end

  task :seed do
    require "sequel"

    db_uri = ENV["DATABASE_URL"] || "sqlite://db/treestats.db"

    Sequel.connect(db_uri) do |db|
      Dir[__dir__ + "/models/*"].each { |f| require f }

      # Kolthar
      kolthar = Character.new(
        server: "WintersEbb",
        name: "Kolthar",
        heritage_id: 0,
        gender_id: 0,
        level: 275,
        current_title: 1,
        birth: DateTime.now.to_time.utc,
        deaths: 100,
        total_xp: 100,
        unassigned_xp: 100,
        luminance_total: 100,
        luminance_earned: 100,
        skill_credits: 5,
        allegiance_name: "ALLEGIANCE",
        rank: 2,
        followers: 1,
        monarch_id: 1,
        strength_creation: 100,
        strength_base: 100,
        endurance_creation: 100,
        endurance_base: 100,
        coordination_creation: 100,
        coordination_base: 100,
        quickness_creation: 100,
        quickness_base: 100,
        focus_creation: 100,
        focus_base: 100,
        self_creation: 100,
        self_base: 100,
        health_base: 100,
        stamina_base: 100,
        mana_base: 100
      ).save

      (1..20).each do |i|
        Skill.new(character_id: kolthar.id,
                  skill_id: i,
                  training_id: (0..3).to_a.sample,
                  base: 100).save
      end

      (1..10).each do |i|
        Title.new(
          character_id: kolthar.id,
          title_id: i
        ).save
      end

      (1..10).each do |i|
        Property.new(
          character_id: kolthar.id,
          property_id: i,
          value: 10
        ).save
      end

      # Kolth
      kolth = Character.new(
        server: "WintersEbb",
        name: "Kolth",
        heritage_id: 0,
        gender_id: 0,
        rank: 1,
        level: 126,
        current_title: 1,
        birth: DateTime.now.to_time.utc,
        deaths: 100,
        total_xp: 100,
        unassigned_xp: 100,
        luminance_total: 100,
        luminance_earned: 100,
        skill_credits: 5,
        allegiance_name: "ALLEGIANCE",
        followers: 0,
        monarch_id: kolthar.id,
        patron_id: kolthar.id,
        strength_creation: 100,
        strength_base: 100,
        endurance_creation: 100,
        endurance_base: 100,
        coordination_creation: 100,
        coordination_base: 100,
        quickness_creation: 100,
        quickness_base: 100,
        focus_creation: 100,
        focus_base: 100,
        self_creation: 100,
        self_base: 100,
        health_base: 100,
        stamina_base: 100,
        mana_base: 100
      ).save

      (1..20).each do |i|
        Skill.new(character_id: kolth.id,
                  skill_id: i,
                  training_id: (0..3).to_a.sample,
                  base: 100).save
      end

      (1..10).each do |i|
        Title.new(
          character_id: kolth.id,
          title_id: i
        ).save
      end

      Character.new(
        server: "WintersEbb",
        name: "Kol'thar",
        heritage_id: 0,
        gender_id: 0,
        rank: 1,
        level: 50,
        current_title: 1,
        birth: DateTime.now.to_time.utc,
        deaths: 100,
        total_xp: 100,
        unassigned_xp: 100,
        luminance_total: 100,
        luminance_earned: 100,
        skill_credits: 5,
        allegiance_name: "ALLEGIANCE",
        followers: 0,
        monarch_id: kolthar.id,
        patron_id: kolthar.id,
        strength_creation: 100,
        strength_base: 100,
        endurance_creation: 100,
        endurance_base: 100,
        coordination_creation: 100,
        coordination_base: 100,
        quickness_creation: 100,
        quickness_base: 100,
        focus_creation: 100,
        focus_base: 100,
        self_creation: 100,
        self_base: 100,
        health_base: 100,
        stamina_base: 100,
        mana_base: 100
      ).save

      Character.new(
        server: "WintersEbb",
        name: "Someone",
        heritage_id: 0,
        gender_id: 0,
        rank: 1,
        level: 50,
        current_title: 1,
        birth: DateTime.now.to_time.utc,
        deaths: 100,
        total_xp: 100,
        unassigned_xp: 100,
        luminance_total: 100,
        luminance_earned: 100,
        skill_credits: 5,
        followers: 0,
        strength_creation: 100,
        strength_base: 100,
        endurance_creation: 100,
        endurance_base: 100,
        coordination_creation: 100,
        coordination_base: 100,
        quickness_creation: 100,
        quickness_base: 100,
        focus_creation: 100,
        focus_base: 100,
        self_creation: 100,
        self_base: 100,
        health_base: 100,
        stamina_base: 100,
        mana_base: 100
      ).save

      Tree.new(2, "TWO_LEVELS")
      Tree.new(3, "THREE_LEVELS")
      Tree.new(4, "FOUR_LEVELS")
      Tree.new(5, "FIVE_LEVELS")

      # Seed Populations
      (0..8).each do |i|
        Population.new(
          server_id: i,
          count: rand(500),
          created_at: "2012-10-03 02:02:52.893375"
        ).save

        Population.new(
          server_id: i,
          count: rand(500),
          created_at: "2013-10-04 02:02:52.893375"
        ).save

        Population.new(
          server_id: i,
          count: rand(500),
          created_at: "2014-10-05 02:02:52.893375"
        ).save

        Population.new(
          server_id: i,
          count: rand(500),
          created_at: "2015-10-05 02:02:52.893375"
        ).save

        Population.new(
          server_id: i,
          count: rand(500),
          created_at: "2016-10-05 02:02:52.893375"
        ).save
      end
    end
  end
end
