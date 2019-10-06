# frozen_string_literal: true

module Sinatra
  module MasteryHelper
    MASTERY_TYPE = {
      melee: 354,
      ranged: 355,
      summoning: 362,
    }

    MASTERY = {
      MASTERY_TYPE[:melee] => {
        1 => "Unarmed",
        2 => "Swords",
        3 => "Axes",
        4 => "Maces",
        6 => "Daggers",
        7 => "Staves",
        9 => "Crossbows",
        11 => "Two-Handed",
      },
      MASTERY_TYPE[:ranged] => {
        8 => "Bows",
        10 => "Thrown Weapons",
        12 => "Magical Spells",
      },
      MASTERY_TYPE[:summoning] => {
        1 => "Primalist",
        2 => "Necromancer",
        3 => "Naturalist",
      },
    }

    def mastery(type, value)
      MASTERY[type][value]
    end
  end

  helpers MasteryHelper
end
