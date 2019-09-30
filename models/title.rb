# frozen_string_literal: true

class Title < Sequel::Model
  plugin :json_serializer

  many_to_one :character

  def to_json(options)
    Sinatra::EnumHelper.title(self.title_id).to_json
  end
end
