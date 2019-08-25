# frozen_string_literal: true

class Character < Sequel::Model
  one_to_many :skills
  one_to_many :titles
  many_to_one :patron, class: self
  one_to_many :vassals, key: :patron_id, class: self
end