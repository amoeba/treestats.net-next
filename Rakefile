require "date"

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect("sqlite://db/treestats.db") do |db|
      Sequel::Migrator.run(db, "db/migrations", target: version)
    end
  end

  task :drop do
    `rm db/treestats.db`
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
          title_id: i).save
      end

      (1..10).each do |i|
        Property.new(
          character_id: kolthar.id,
          property_id: i,
          value: 10).save
      end

      # Kolth
      kolth = Character.new(
        server: "WintersEbb",
        name: "Kolth",
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
          title_id: i).save
      end

      kol_thar = Character.new(
        server: "WintersEbb",
        name: "Kol'thar",
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

      puts Character.count
      puts Skill.count
      puts Title.count
      puts Property.count
    end
  end
end