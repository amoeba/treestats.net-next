# frozen_string_literal: true

class Property < Sequel::Model
  many_to_one :characters
end
