require "securerandom"

class Tree
  def initialize(depth, size = 2)
    @depth = depth
    @size = size

    build
  end

  def build(parent = nil, level = 0)
    return if level > @depth

    char = Character.new(
      server: "WintersEbb",
      name: SecureRandom.alphanumeric.gsub(/[^a-zA-Z'\-\+ ]/, ""),
      race_id: 0,
      gender_id: 0,
      rank: 1,
      patron_id: parent,
      level: 275,
      current_title: 1,
      birth: DateTime.now.to_time.utc,
      deaths: 0,
      total_xp: 0,
      unassigned_xp: 0,
      luminance_total: 0,
      luminance_earned: 0,
      skill_credits: 0,
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

    (1..@size).each do |i|
      build(char.id, level+1)
    end


    char.id
  end
end
