# frozen_string_literal: true

module Sinatra
  module GenderHelper
    GENDER = [
      "Male",
      "Female",
    ]

    def gender_name(id)
      GENDER[id]
    end
  end

  helpers GenderHelper
end
