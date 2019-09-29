# frozen_string_literal: true

module Sinatra
  module AppHelper
    def get_page(params)
      return 1 unless params.is_a?(Hash)
      return 1 if params[:page].nil?

      page = params[:page].to_i
      page = 1 if page <= 0

      page
    end

    def to_params(params)
      return "" unless params.is_a?(Hash)

      URI.encode_www_form(params)
    end

    def with_commas(string)
      string.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def get_mastery(properties, type)
      return nil unless properties[type]

      mastery(Sinatra::EnumHelper::MASTERY[type], properties[type][:value])
    end

    def get_society(properties)
      society_ids = properties.filter { |k, p| p[:id] >= 287 && p[:id] <= 289 }

      if society_ids.length != 1
        return nil
      end

      society_ids.first[1]
    end

    def get_properties(props)
      # Add in values
      properties = props.to_h { |p|
        prop = property(p[:property_id])

        [
          prop[:key],
          prop.merge({
            id: p[:property_id],
            value: p[:value],
          }),
        ]
      }

      {
        augmentations: properties.filter { |k, p| p[:type] == :aug }.sort_by { |k, p| p[:name] }.to_h,
        auras: properties.filter { |k, p| p[:type] == :aura }.sort_by { |k, p| p[:name] }.to_h,
        ratings: properties.filter { |k, p| p[:type] == :rating }.sort_by { |k, p| p[:name] }.to_h,

        masteries: {
          melee: get_mastery(properties, :melee),
          ranged: get_mastery(properties, :ranged),
          summoning: get_mastery(properties, :summoning),
        },

        housing_purchase_date: get_property(properties, :housing_purchase_date),
        fishing_skill: get_property(properties, :fishing_skill),
        chess_rank: get_property(properties, :chess_rank),
        aetheria_slots: get_property(properties, :aetheria_slots),
        times_enlightened: get_property(properties, :times_enlightened),

        society: get_society(properties),
      }
    end

    # nil-safe property getter
    def get_property(properties, key)
      return nil unless properties.key?(key)

      properties[key][:value]
    end

    def get_property_value(properties, id)
      properties = properties.filter { |p| p[:property_id] == id }

      if properties.length != 1
        puts "#{id} is length #{properties.length}, returning nil"
        return nil
      end

      puts "id => #{properties.first}"
      properties.first[:value]
    end
  end

  helpers AppHelper
end
