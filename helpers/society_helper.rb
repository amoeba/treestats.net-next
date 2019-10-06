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
        return "Initiate"
      elsif standing < 301
        return "Adept"
      elsif standing < 601
        return "Knight"
      elsif standing < 1001
        return "Lord"
      elsif standing == 1001
        return "Master"
      else
        return "Unknown"
      end
    end
  end

  helpers SocietyHelper
end
