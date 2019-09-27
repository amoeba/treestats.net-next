# frozen_string_literal: true

class Account < Sequel::Model
  plugin :update_or_create

  one_to_many :characters
end
