# frozen_string_literal: true

require_relative "../helpers/heritage_helper"
require_relative "../helpers/gender_helper"

class Character < Sequel::Model
  plugin :update_or_create
  plugin :timestamps
  plugin :json_serializer

  one_to_many :skills
  one_to_many :titles
  one_to_many :properties

  # Allegiance relationships
  many_to_one :patron, class: self
  many_to_one :monarch, key: :monarch_id, class: self
  one_to_many :vassals, key: :patron_id, class: self

  # Account
  many_to_one :accounts

  def to_json
    # Basics
    char = {
      server: server,
      name: name,
      gender: Sinatra::GenderHelper.gender_name(gender_id),
      heritage: Sinatra::HeritageHelper.heritage_name(heritage_id),
      rank: rank
    }

    return char.to_json unless level

    char[:level] = level
    char[:birth] = birth
    char[:deaths] = "%d" % deaths
    char[:total_xp] = "%d" % total_xp
    char[:unassigned_xp] = "%d" % unassigned_xp
    char[:luminance_earned] = "%d" % luminance_earned
    char[:skill_credits] = skill_credits
    char[:allegiance_name] = allegiance_name
    char[:followers] = followers

    if monarch
      char[:monarch] = {
        name: monarch.name
      }
    end

    if patron
      char[:patron] = {
        name: patron.name
      }
    end

    if vassals
      char[:vassals] = vassals.map { |v| v.name }
    end

    char[:created_at] = created_at
    char[:updated_at] = updated_at

    char[:attributes] = {
      strength: {
        creation: strength_creation,
        base: strength_base
      },
      endurance: {
        creation: endurance_creation,
        base: endurance_base
      },
      coordination: {
        creation: coordination_creation,
        base: coordination_base
      },
      quickness: {
        creation: quickness_creation,
        base: quickness_base
      },
      focus: {
        creation: focus_creation,
        base: focus_base
      },
      self: {
        creation: self_creation,
        base: self_base
      }
    }

    char[:vitals] = {
      health: {
        base: health_base
      },
      stamina: {
        base: stamina_base
      },
      mana: {
        base: mana_base
      }
    }

    char[:skills] = skills
    char[:titles] = titles
    char[:properties] = properties.select { |p| p[:name] != "UNK" }

    char.to_json
  end
end
