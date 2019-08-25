# frozen_string_literal: true

class Title < Sequel::Model
  many_to_one :characters
end