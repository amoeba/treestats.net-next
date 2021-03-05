# frozen_string_literal: true

require_relative "../helpers/skill_helper"

class Skill < Sequel::Model
  plugin :json_serializer

  many_to_one :character

  def to_json(options)
    {
      name: Sinatra::SkillHelper.skill_name(skill_id),
      training: Sinatra::SkillHelper.training(training_id),
      base: base
    }.to_json
  end
end
