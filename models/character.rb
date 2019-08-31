# frozen_string_literal: true

class Character < Sequel::Model
  one_to_many :skills
  one_to_many :titles
  one_to_many :vassals, key: :patron_id, class: self
end