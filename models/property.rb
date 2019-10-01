# frozen_string_literal: true

class Property < Sequel::Model
  plugin :json_serializer

  many_to_one :character

  def to_json(options)
    prop = Sinatra::EnumHelper.property(property_id)

    result = {
      name: prop[:name],
      type: prop[:type],
      value: value,
    }

    result.to_json
  end
end
