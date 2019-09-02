# frozen_string_literal: true

module Sinatra
  module RankingsHelper
    def get_ranking(ranking)
      Rankings.send(ranking)
    end

    class Rankings
      def self.level
        Character.order(Sequel.desc(:level)).limit(10)
      end
    end
  end

  helpers RankingsHelper
end
