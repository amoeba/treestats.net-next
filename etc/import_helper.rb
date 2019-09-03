module ImportHelper
  RACE_ID = {
    "Aluvian" => 0,
    "Gharu'ndim" => 1,
    "Sho" => 2,
    "Viamontian" => 3,
    "Shadowbound" => 4,
    "Gearknight" => 5,
    "Tumerok" => 6,
    "Lugian" => 7,
    "Empyrean" => 8,
    "Penumbraen" => 9,
    "Undead" => 10,
    "Olthoi" => 11,
    "OlthoiAcid"  => 12
  }

  def self.race_id(name)
    RACE_ID[name]
  end

  GENDER_ID = {
    "Male" => 0,
    "Female" => 1
  }

  def self.gender_id(name)
    GENDER_ID[name]
  end

  SKILL = {
    "alchemy" => 0,
    "arcane_lore" => 1,
    "armor_tinkering" => 2,
    "assess_creature" => 3,
    "assess_person" => 4,
    "cooking" => 5,
    "creature_enchantment" => 6,
    "deception" => 7,
    "dirty_fighting" => 8,
    "dual_wield" => 9,
    "fletching" => 10,
    "finesse_weapons" => 11,
    "healing" => 12,
    "heavy_weapons" => 13,
    "item_enchantment" => 14,
    "item_tinkering" => 15,
    "jump" => 16,
    "leadership" => 17,
    "life_magic" => 18,
    "light_weapons" => 19,
    "lockpick" => 20,
    "loyalty" => 21,
    "magic_defense" => 22,
    "magic_item_tinkering" => 23,
    "mana_conversion" => 24,
    "melee_defense" => 25,
    "missile_defense" => 26,
    "missile_weapons" => 27,
    "recklessness" => 28,
    "run" => 29,
    "salvaging" => 30,
    "shield" => 31,
    "sneak_attack" => 32,
    "two_handed_combat" => 33,
    "summoning" => 34,
    "void_magic" => 35,
    "war_magic" => 36,
    "weapon_tinkering" => 37,
  }

  def self.skill_id(name)
    SKILL[name]
  end

  TRAINING = {
    "Unusable" => 0,
    "Untrained" => 1,
    "Trained" => 2,
    "Specialized" => 4
  }
  def self.training_id(name)
    TRAINING[name]
  end
end