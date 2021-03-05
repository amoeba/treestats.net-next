# frozen_string_literal: true

module Sinatra
  module GenderHelper
    GENDER = [
      "Male",
      "Female"
    ]

    def gender_name(id)
      GENDER[id]
    end

    module_function :gender_name
  end

  helpers GenderHelper
end
