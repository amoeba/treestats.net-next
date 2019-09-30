# frozen_string_literal: true

require_relative "../helpers/enum_helper"

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
      server: self.server,
      name: self.name,
      gender: Sinatra::EnumHelper.gender(self.gender_id),
      race: Sinatra::EnumHelper.race(self.race_id),
      rank: self.rank
    }

    return char.to_json unless self.level

    char[:level] = self.level
    char[:birth] = self.birth
    char[:deaths] = "%d" % self.deaths
    char[:total_xp] = "%d" % self.total_xp
    char[:unassigned_xp] = "%d" % self.unassigned_xp
    char[:luminance_earned] = "%d" % self.luminance_earned
    char[:skill_credits] = self.skill_credits
    char[:allegiance_name] = self.allegiance_name
    char[:followers] = self.followers

    if self.monarch
      char[:monarch] = {
        name: self.monarch.name
      }
    end

    if self.patron
      char[:patron] = {
        name: self.patron.name
      }
    end

    if self.vassals
      char[:vassals] = self.vassals.map { |v| v.name }
    end

    char[:created_at] = self.created_at
    char[:updated_at] = self.updated_at

    char[:attributes] = {
      strength: {
        creation: self.strength_creation,
        base: self.strength_base
      },
      endurance: {
        creation: self.endurance_creation,
        base: self.endurance_base
      },
      coordination: {
        creation: self.coordination_creation,
        base: self.coordination_base
      },
      quickness: {
        creation: self.quickness_creation,
        base: self.quickness_base
      },
      focus: {
        creation: self.focus_creation,
        base: self.focus_base
      },
      self: {
        creation: self.self_creation,
        base: self.self_base
      },
    }

    char[:vitals] = {
      health: {
        base: self.health_base
      },
      stamina: {
        base: self.stamina_base
      },
      mana: {
        base: self.mana_base
      },
    }

    char[:skills] = self.skills
    char[:titles] = self.titles
    char[:properties] = self.properties.select { |p| p[:name] != "UNK" }

    char.to_json
  end
end
