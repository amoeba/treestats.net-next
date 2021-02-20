# frozen_string_literal: true

module Sinatra
  module UploadHelper
    class UploadException < StandardError
    end

    class Upload
      attr_accessor :data

      def initialize(data)
        @data = data
      end

      def process
        Character.update_or_create(server: data["server"], name: data["name"]) { |char|
          char.server = data["server"]
          char.name = data["name"]
          char.heritage_id = data["heritage_id"]
          char.gender_id = data["gender_id"]
          char.rank = data["rank"]
        }
      end

      def valid?
        false
      end
    end
  end
end
