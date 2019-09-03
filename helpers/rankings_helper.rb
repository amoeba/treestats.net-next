# frozen_string_literal: true

module Sinatra
  module RankingsHelper
    def get_ranking(params)
      Rankings.send(params[:ranking])
    end

    class Rankings
      def self.level
        Character
          .order(Sequel.desc(:level))
          .limit(25)
      end
    end
  end

  helpers RankingsHelper
end
