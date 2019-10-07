# frozen_string_literal: true

module Sinatra
  module AppHelper
    SERVERS = %w{Darktide Frostfell Harvestgain Leafcull Morningthaw Thistledown
       Solclaim Verdantine WintersEbb}

    def servers
      SERVERS
    end

    # Paging stuff
    def get_page(params)
      return 1 unless params.is_a?(Hash)
      return 1 if params[:page].nil?

      page = params[:page].to_i
      page = 1 if page <= 0

      page
    end

    # Returns details we need to run a paged query and render page controls
    def get_page_params(params, count, limit = 25)
      page = get_page(params)

      {
        page: page,
        limit: limit,
        offset: (page - 1) * limit,
        more: count > page * limit,
      }
    end

    def to_params(params)
      return "" unless params.is_a?(Hash)

      URI.encode_www_form(params)
    end

    def with_commas(string)
      string.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end
  end

  helpers AppHelper
end
