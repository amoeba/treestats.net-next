# frozen_string_literal: true

module Sinatra
  module SkillHelper
    SKILL_KEY = [
      "alchemy",
      "arcane_lore",
      "armor_tinkering",
      "assess_creature",
      "assess_person",
      "cooking",
      "creature_enchantment",
      "deception",
      "dirty_fighting",
      "dual_wield",
      "fletching",
      "finesse_weapons",
      "healing",
      "heavy_weapons",
      "item_enchantment",
      "item_tinkering",
      "jump",
      "leadership",
      "life_magic",
      "light_weapons",
      "lockpick",
      "loyalty",
      "magic_defense",
      "magic_item_tinkering",
      "mana_conversion",
      "melee_defense",
      "missile_defense",
      "missile_weapons",
      "recklessness",
      "run",
      "salvaging",
      "shield",
      "sneak_attack",
      "two_handed_combat",
      "summoning",
      "void_magic",
      "war_magic",
      "weapon_tinkering"
    ]

    SKILL = [
      "Alchemy",
      "Arcane Lore",
      "Armor Tinkering",
      "Assess Creature",
      "Assess Person",
      "Cooking",
      "Creature Enchantment",
      "Deception",
      "Dirty Fighting",
      "Dual Wield",
      "Fletching",
      "Finesse Weapons",
      "Healing",
      "Heavy Weapons",
      "Item Enchantment",
      "Item Tinkering",
      "Jump",
      "Leadership",
      "Life Magic",
      "Light Weapons",
      "Lockpick",
      "Loyalty",
      "Magic Defense",
      "Magic Item Tinkering",
      "Mana Conversion",
      "Melee Defense",
      "Missile Defense",
      "Missile Weapons",
      "Recklessness",
      "Run",
      "Salvaging",
      "Shield",
      "Sneak Attack",
      "Two Handed Combat",
      "Summoning",
      "Void Magic",
      "War Magic",
      "Weapon Tinkering"
    ]

    SKILL_ID = {
      alchemy: 0,
      arcane_lore: 1,
      armor_tinkering: 2,
      assess_creature: 3,
      assess_person: 4,
      cooking: 5,
      creature_enchantment: 6,
      deception: 7,
      dirty_fighting: 8,
      dual_wield: 9,
      fletching: 10,
      finesse_weapons: 11,
      healing: 12,
      heavy_weapons: 13,
      item_enchantment: 14,
      item_tinkering: 15,
      jump: 16,
      leadership: 17,
      life_magic: 18,
      light_weapons: 19,
      lockpick: 20,
      loyalty: 21,
      magic_defense: 22,
      magic_item_tinkering: 23,
      mana_conversion: 24,
      melee_defense: 25,
      missile_defense: 26,
      missile_weapons: 27,
      recklessness: 28,
      run: 29,
      salvaging: 30,
      shield: 31,
      sneak_attack: 32,
      two_handed_combat: 33,
      summoning: 34,
      void_magic: 35,
      war_magic: 36,
      weapon_tinkering: 37
    }

    TRAINING = [
      "Unusable",
      "Untrained",
      "Trained",
      "Specialized"
    ]

    TRAINING_ID = {
      unusable: 0,
      untrained: 1,
      trained: 2,
      specialized: 3
    }

    def skill_key(id)
      SKILL_KEY[id]
    end

    def skill_name(id)
      SKILL[id]
    end

    module_function :skill_name

    def skill_id(key)
      SKILL_ID[key]
    end

    module_function :skill_id

    def training(id)
      TRAINING[id]
    end

    module_function :training
  end

  helpers SkillHelper
end
