# frozen_string_literal: true
require_relative "./enum_helper"

module Sinatra
  module RankingsHelper
    RANKINGS = [
      :level,
      :strength_base,
      :endurance_base,
      :coordination_base,
      :quickness_base,
      :focus_base,
      :self_base,
      :health_base,
      :stamina_base,
      :mana_base,
      :alchemy
    ]

    VALUE_COL = {
      :level => :level,
      :strength_base => :strength_base,
      :endurance_base => :endurance_base,
      :coordination_base => :coordination_base,
      :quickness_base => :quickness_base,
      :focus_base => :focus_base,
      :self_base => :self_base,
      :health_base => :health_base,
      :stamina_base => :stamina_base,
      :mana_base => :mana_base,
      :alchemy => :base
    }

    def value_col(ranking)
      VALUE_COL[ranking]
    end

    def get_ranking(params)
      ranking = params[:ranking].to_sym

      if !RANKINGS.include?(ranking)
        halt(404, "Ranking '#{ranking}' not found.")
      end

      if ranking == :alchemy
        puts "SKILL"
        Rankings.skill(params)
      else
        puts "ELSE"
        Rankings.default(params)
      end
    end

    class Rankings
      extend EnumHelper

      def self.default(*args)
        params = args[0]
        ranking = params[:ranking].to_sym

        Character
          .order(ranking)
          .reverse
          .limit(params[:limit])
          .offset(params[:offset])
      end

      def self.skill(*args)
        params = args[0]
        ranking = params[:ranking].to_sym

        Skill
          .where(skill_id: skill_id(ranking))
          .order(VALUE_COL[ranking])
          .reverse
          .limit(params[:limit])
          .offset(params[:offset])
          .association_join(:character)
      end
    end
  end

  helpers RankingsHelper
end
