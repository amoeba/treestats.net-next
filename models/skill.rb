# frozen_string_literal: true

class Skill < Sequel::Model
  many_to_one :characters
end
