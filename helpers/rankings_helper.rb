# frozen_string_literal: true

module Sinatra
  module RankingsHelper
    def get_ranking(params)
      Rankings.send(params[:ranking], params)
    end

    class Rankings
      def self.level(*args)
        params = args[0]

        Character
          .order(params[:ranking])
          .reverse
          .limit(params[:limit])
          .offset(params[:offset])
      end
    end
  end

  helpers RankingsHelper
end
