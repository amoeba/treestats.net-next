# frozen_string_literal: true

require "date"
require 'bundler/setup'
Bundler.require(:default)

require "./etc/import_helper"

task default: :test

task :test do
  Dir['./test/*_test.rb'].each { |f| load f }
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

  task :drop do
    desc "Delete database"
    `rm db/treestats.db`
  end

  task :import, [:path] do |t, args|
    desc "Import data from JSON files"

    require "json"
    files = Dir.glob("#{args[:path]}/*.json")

    if files.length <= 0
      raise("No files found at path #{args[:path]}.")
    end

    require "sequel"

    Sequel.connect("sqlite://db/treestats.db") do |db|
      require_relative "models/character"
      require_relative "models/skill"
      require_relative "models/title"
      require_relative "models/property"

      files.each do |file|
        puts file
        contents = File.read(file)

        contents.split("\n").each do |line|
          data = JSON.parse(line)
          puts data
          puts "#{data["s"]}/#{data["n"]}"

          char = Character.update_or_create(server: data["s"], name: data["n"]) do |char|
            # Update monarch, patron before
            monarch = nil

            if data["m"]
              monarch = Character.update_or_create(server: data["s"], name: data["m"]["name"]) do |m|
                m.rank = data["m"]["rank"]
                m.race_id = ImportHelper::race_id(data["m"]["race"])
                m.gender_id = ImportHelper::gender_id(data["m"]["gender"])
                m.followers = data["m"]["followers"]

                if m.gender_id > 1
                  raise Exception
                end
              end
            end

            patron = nil

            if data["p"]
              patron = Character.update_or_create(server: data["s"], name: data["p"]["name"]) do |p|
                p.rank = data["p"]["rank"]
                p.race_id = ImportHelper::race_id(data["p"]["race"])
                p.gender_id = ImportHelper::gender_id(data["p"]["gender"])
                p.followers = data["p"]["followers"]

                if p.gender_id > 1
                  raise Exception
                end
              end
            end

            char.server = data["s"]
            char.name = data["n"]
            char.race_id = ImportHelper::race_id(data["r"])
            char.gender_id = ImportHelper::gender_id(data["g"])

            if char.gender_id > 1
              raise Exception
            end

            char.rank = data["rn"]
            char.allegiance_name = data["an"]
            char.created_at = data["c_at"]
            char.updated_at = data["u_at"]

            if data["a"]
              char.level = data["l"]
              char.deaths = data["d"]
              char.birth = data["b"] # TODO: Handle right
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
              char.total_xp = data["tx"]
              char.unassigned_xp = data["u"]
              char.skill_credits = data["sc"]
              char.luminance_total = data["lt"]
              char.luminance_earned = data["lx"]
            end


            if monarch
              puts "Setting #{data["n"]}'s monarch to #{monarch.name}."
              char.monarch_id = monarch.id
            end

            if patron
              puts "Setting #{data["n"]}'s patron to #{patron.name}."
              char.patron_id = patron.id
            end
          end

          if data["sk"]
            data["sk"].each do |k,v|
              skill_id = ImportHelper::skill_id(v["name"])
              next if skill_id.nil?

              Skill.new(
                character_id: char.id,
                skill_id: skill_id,
                training_id: ImportHelper::training_id(v["training"]),
                base: v["base"]
              ).save
            end
          end

          if data["ti"]
            data["ti"].each do |t|
              Title.new(
                character_id: char.id,
                title_id: t
              ).save
            end
          end

          if data["pr"]
            data["pr"].each do |k,v|
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
  end

  task :seed do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:migrate"].invoke

    require "sequel"

    Sequel.connect("sqlite://db/treestats.db") do |db|
      require_relative "models/character"
      require_relative "models/skill"
      require_relative "models/title"
      require_relative "models/property"

      # Kolthar
      kolthar = Character.new(
        server: "WintersEbb",
        name: "Kolthar",
        race_id: 0,
        gender_id: 0,
        level: 275,
        current_title: 1,
        birth: Date.new,
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
        race_id: 0,
        gender_id: 0,
        level: 126,
        current_title: 1,
        birth: Date.new,
        deaths: 100,
        total_xp: 100,
        unassigned_xp: 100,
        luminance_total: 100,
        luminance_earned: 100,
        skill_credits: 5,
        allegiance_name: "ALLEGIANCE",
        rank: 0,
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

      kol_thar = Character.new(
        server: "WintersEbb",
        name: "Kol'thar",
        race_id: 0,
        gender_id: 0,
        level: 50,
        current_title: 1,
        birth: Date.new,
        deaths: 100,
        total_xp: 100,
        unassigned_xp: 100,
        luminance_total: 100,
        luminance_earned: 100,
        skill_credits: 5,
        allegiance_name: "ALLEGIANCE",
        rank: 0,
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
        name: "Stub",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        followers: 0,
        monarch_id: kolthar.id,
        patron_id: kol_thar.id,
      ).save

      # Make a deep chain
      top = Character.new(
        server: "WintersEbb",
        name: "TopTen",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        followers: 0
      ).save
      parent = top

      (1..10).each do |i|
        parent = Character.new(
          server: "WintersEbb",
          name: "TopTen",
          race_id: 0,
          gender_id: 0,
          rank: 0,
          followers: 0,
          patron_id: parent.id,
          monarch_id: top.id
        ).save
      end

      # Make a deeper chain
      top = Character.new(
        server: "WintersEbb",
        name: "TopThousand",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        followers: 0
      ).save
      parent = top

      (1..1000).each do |i|
        parent = Character.new(
          server: "WintersEbb",
          name: "TopThousand",
          race_id: 0,
          gender_id: 0,
          rank: 0,
          followers: 0,
          patron_id: parent.id,
          monarch_id: top.id
        ).save
      end

      # Make a pretty tree
      a = Character.new(
        server: "WintersEbb",
        name: "A",
        race_id: 0,
        gender_id: 0,
        rank: 0
      ).save

      b1 = Character.new(
        server: "WintersEbb",
        name: "BA",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: a.id
      ).save

      b2 = Character.new(
        server: "WintersEbb",
        name: "BB",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: a.id
      ).save

      c1 = Character.new(
        server: "WintersEbb",
        name: "CA",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: b1.id
      ).save

      c2 = Character.new(
        server: "WintersEbb",
        name: "CB",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: b1.id
      ).save

      c3 = Character.new(
        server: "WintersEbb",
        name: "CC",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: b2.id
      ).save

      c4 = Character.new(
        server: "WintersEbb",
        name: "CD",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: b2.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DA",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c1.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DB",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c1.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DC",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c2.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DD",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c2.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DE",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c3.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DF",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c3.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DG",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c4.id
      ).save

      Character.new(
        server: "WintersEbb",
        name: "DH",
        race_id: 0,
        gender_id: 0,
        rank: 0,
        patron_id: c4.id
      ).save

      puts Character.count
      puts Skill.count
      puts Title.count
      puts Property.count
    end
  end
end
