# frozen_string_literal: true

require_relative "../helpers/property_helper"

class Property < Sequel::Model
  plugin :json_serializer

  many_to_one :character

  def to_json(options)
    prop = Sinatra::PropertyHelper.property(property_id)

    result = {
      name: prop[:name],
      type: prop[:type],
      value: value
    }

    result.to_json
  end
end
