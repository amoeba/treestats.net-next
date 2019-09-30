# frozen_string_literal: true

class Property < Sequel::Model
  plugin :json_serializer

  many_to_one :character
end
