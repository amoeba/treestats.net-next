# frozen_string_literal: true

class Title < Sequel::Model
  plugin :json_serializer

  many_to_one :character

  def to_json(options)
    Sinatra::TitleHelper.title(title_id).to_json
  end
end
