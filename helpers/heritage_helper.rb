# frozen_string_literal: true

module Sinatra
  module HeritageHelper
    HERITAGE = [
      "Aluvian",
      "Gharu'ndim",
      "Sho",
      "Viamontian",
      "Umbraen",
      "Gearknight",
      "Aun Tumerok",
      "Lugian",
      "Empyrean",
      "Penumbraen",
      "Undead",
    ]

    def heritage_name(id)
      HERITAGE[id]
    end

    module_function :heritage_name
  end

  helpers HeritageHelper
end
