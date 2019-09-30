# frozen_string_literal: true

class Skill < Sequel::Model
  plugin :json_serializer

  many_to_one :character
end
