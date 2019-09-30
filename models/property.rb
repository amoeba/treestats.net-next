# frozen_string_literal: true

class Property < Sequel::Model
  plugin :json_serializer

  many_to_one :character

  def to_json(options)
    {
      name: Sinatra::EnumHelper.property(self.property_id)[:name],
      value: self.value,
    }.to_json
  end
end
