# frozen_string_literal: true

module Sinatra
  module MasteryHelper
    MASTERY_TYPE = {
      melee: 354,
      ranged: 355,
      summoning: 362
    }

    MASTERY = {
      melee: {
        1 => "Unarmed",
        2 => "Swords",
        3 => "Axes",
        4 => "Maces",
        6 => "Daggers",
        7 => "Staves",
        9 => "Crossbows",
        11 => "Two-Handed"
      },
      ranged: {
        8 => "Bows",
        10 => "Thrown Weapons",
        12 => "Magical Spells"
      },
      summoning: {
        1 => "Primalist",
        2 => "Necromancer",
        3 => "Naturalist"
      }
    }

    def mastery(type, value)
      MASTERY[type][value]
    end

    def get_mastery(properties, type)
      return nil unless properties[type]

      mastery(type, properties[type][:value])
    end
  end

  helpers MasteryHelper
end
