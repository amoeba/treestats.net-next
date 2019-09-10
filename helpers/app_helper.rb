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

      query_string = "?"

      params.each do |k, v|
        query_string += "#{k}=#{URI.encode(v.to_s)}&"
      end

      query_string.chop!
      query_string
    end

    def with_commas(string)
      string.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end
  end

  helpers AppHelper
end