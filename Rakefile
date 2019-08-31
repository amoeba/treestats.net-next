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

      # Kolthar
      kolthar = Character.new(
        server: "WintersEbb", 
        name: "Kolthar",
        race_id: 0,
        gender_id: 0).save

      (1..20).each do |i|
        Skill.new(character_id: kolthar.id, 
          skill_id: i, 
          training_id: (0..3).to_a.sample).save
        end

      (1..10).each do |i|
        Title.new(
          character_id: kolthar.id,
          title_id: i).save
      end

      # Kolth
      kolth = Character.new(
        server: "WintersEbb", 
        name: "Kolth", 
        patron: "Kolthar",
        race_id: 0,
        gender_id: 0).save

      (1..20).each do |i|
        Skill.new(character_id: kolth.id, 
          skill_id: i, 
          training_id: (0..3).to_a.sample).save
        end

      (1..10).each do |i|
        Title.new(
          character_id: kolth.id,
          title_id: i).save
      end

      puts Character.count
      puts Skill.count
    end
  end
end