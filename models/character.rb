# frozen_string_literal: true

class Character < Sequel::Model
  one_to_many :skills
  one_to_many :titles

  # Monarch relationship
  many_to_one :patron, class: self
  one_to_one :monarch, key: :monarch_id, class: self

  # Patron/vassal relationship
  many_to_one :patron, class: self
  one_to_many :vassals, key: :patron_id, class: self
end