# frozen_string_literal: true

module Sinatra
  module RankingsHelper
    def get_ranking(params)
      Rankings.send(params[:ranking], params)
    end

    class Rankings
      def self.level(*args)
        params = args[0]
        ranking = params[:ranking].to_sym

        query = Character
          .order(ranking)
          .reverse
          .limit(params[:limit])
          .offset(params[:offset])

        puts query.sql
        query
      end
    end
  end

  helpers RankingsHelper
end
