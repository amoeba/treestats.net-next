# frozen_string_literal: true
require_relative "./enum_helper"

module Sinatra
  module RankingsHelper
    extend EnumHelper

    # All enabled rankings and which method we use to call them. A 404 results
    # if the ranking isn't in this list.
    RANKINGS = {
      :strength_base => :character,
      :endurance_base => :character,
      :coordination_base => :character,
      :quickness_base => :character,
      :focus_base => :character,
      :self_base => :character,
      :health_base => :character,
      :stamina_base => :character,
      :mana_base => :character,
      :alchemy => :skill,
      :level => :character
    }

    # Which database column to pull each ranking type's value from. If not
    # present, assume we can use the ranking as-is.
    VALUE_COL = {
      :skill => :base,
    }

    # Return the value column for each ranking type. If not present in
    # VALUE_COL, assume the value column is the same as the ranking itself.
    def value_col(ranking)
      type = RANKINGS[ranking]

      return ranking if !VALUE_COL[type]

      VALUE_COL[type]
    end

    def get_ranking(params)
      ranking = params[:ranking].to_sym

      if !RANKINGS.include?(ranking)
        halt(404, "Ranking '#{ranking}' not found.")
      end

      type = RANKINGS[ranking]

      if type == :skill
        skill(params)
      elsif type == :character
        character(params)
      else
        self.call(ranking, params)
      end
    end

    def character(*args)
      params = args[0]
      ranking = params[:ranking].to_sym

      Character
        .order(ranking)
        .reverse
        .limit(params[:limit])
        .offset(params[:offset])
    end

    def skill(*args)
      params = args[0]
      ranking = params[:ranking].to_sym
      type = RANKINGS[ranking]

      Skill
        .where(skill_id: skill_id(ranking))
        .order(VALUE_COL[type])
        .reverse
        .limit(params[:limit])
        .offset(params[:offset])
        .association_join(:character)
    end
  end

  helpers RankingsHelper
end
