# frozen_string_literal: true

require_relative "./enum_helper"

module Sinatra
  module RankingsHelper
    extend EnumHelper

    # All enabled rankings and which method we use to call them. A 404 results
    # if the ranking isn't in this list.
    RANKINGS = {
      strength_base: :character,
      endurance_base: :character,
      coordination_base: :character,
      quickness_base: :character,
      focus_base: :character,
      self_base: :character,
      health_base: :character,
      stamina_base: :character,
      mana_base: :character,
      alchemy: :skill,
      arcane_lore: :skill,
      armor_tinkering: :skill,
      assess_creature: :skill,
      assess_person: :skill,
      cooking: :skill,
      creature_enchantment: :skill,
      deception: :skill,
      dirty_fighting: :skill,
      dual_wield: :skill,
      fletching: :skill,
      finesse_weapons: :skill,
      healing: :skill,
      heavy_weapons: :skill,
      item_enchantment: :skill,
      item_tinkering: :skill,
      jump: :skill,
      leadership: :skill,
      life_magic: :skill,
      light_weapons: :skill,
      lockpick: :skill,
      loyalty: :skill,
      magic_defense: :skill,
      magic_item_tinkering: :skill,
      mana_conversion: :skill,
      melee_defense: :skill,
      missile_defense: :skill,
      missile_weapons: :skill,
      recklessness: :skill,
      run: :skill,
      salvaging: :skill,
      shield: :skill,
      sneak_attack: :skill,
      two_handed_combat: :skill,
      summoning: :skill,
      void_magic: :skill,
      war_magic: :skill,
      weapon_tinkering: :skill,
      level: :character,
      birth: :character,
      deaths: :character,
      rank: :character,
      followers: :character,
      unassigned_xp: :character,
      total_xp: :character,
      titles: :title,
      times_enlightened: :property,
    }

    # Default is descending, these rankings should be ascending
    ASCENDING = {
      birth: true
    }

    # Which database column to pull each ranking type's value from. If not
    # present, assume we can use the ranking as-is.
    VALUE_COL = {
      skill: :base,
      title: :count,
      property: :value,
    }

    # Return the value column for each ranking type. If not present in
    # VALUE_COL, assume the value column is the same as the ranking itself.
    def value_col(ranking)
      type = RANKINGS[ranking]

      return ranking unless VALUE_COL[type]

      VALUE_COL[type]
    end

    def get_ranking(params)
      ranking = params[:ranking].to_sym

      unless RANKINGS.include?(ranking)
        halt(404, "Ranking '#{ranking}' not found.")
      end

      type = RANKINGS[ranking]

      if type == :character
        character_ranking(params)
      elsif type == :skill
        skill_ranking(params)
      elsif type == :title
        title_ranking(params)
      elsif type == :property
        property_ranking(params)
      else
        call(ranking, params)
      end
    end

    def character_ranking(*args)
      params = args[0]
      ranking = params[:ranking].to_sym

      query = Character
        .order(ranking)
        .limit(params[:limit])
        .offset(params[:offset])
        .exclude({ ranking => nil })

      if ASCENDING.key?(ranking)
        return query
      else
        return query.reverse
      end
    end

    def skill_ranking(*args)
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

    def title_ranking(*args)
      params = args[0]

      q = Title
        .group_and_count(:character_id)
        .order(:count)
        .reverse
        .limit(params[:limit])
        .offset(params[:offset])
        .association_join(:character)
        .select_append(:server, :name)

      q
    end

    def property_ranking(*args)
      params = args[0]
      ranking = params[:ranking].to_sym
      type = RANKINGS[ranking]

      Property
        .where(property_id: property_id(ranking))
        .order(VALUE_COL[type])
        .reverse
        .limit(params[:limit])
        .offset(params[:offset])
        .association_join(:character)
    end
  end

  helpers RankingsHelper
end
