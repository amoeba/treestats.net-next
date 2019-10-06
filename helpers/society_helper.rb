# frozen_string_literal: true

module Sinatra
  module SocietyHelper
    SOCIETY = {
      287 => "Celestial Hand",
      288 => "Eldrytch Web",
      289 => "Radiant Blood",
    }

    def society_name(id)
      SOCIETY[id]
    end

    def society_rank(standing)
      if standing < 101
        "Initiate"
      elsif standing < 301
        "Adept"
      elsif standing < 601
        "Knight"
      elsif standing < 1001
        "Lord"
      elsif standing == 1001
        "Master"
      else
        "Unknown"
      end
    end
  end

  helpers SocietyHelper
end
