# frozen_string_literal: true

require_relative "../helpers/enum_helper"

class Skill < Sequel::Model
  plugin :json_serializer

  many_to_one :character

  def to_json(options)
    {
      name: Sinatra::EnumHelper.skill_name(self.skill_id),
      training: Sinatra::EnumHelper.training(self.training_id),
      base: 300
    }.to_json
  end
end
