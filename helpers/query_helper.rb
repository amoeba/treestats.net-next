# frozen_string_literal: true

module Sinatra
  module RankingsHelper
    def ultimate_patron(server, name)
      patron_query = <<-QUERY
        WITH RECURSIVE
        children(n) AS (
        VALUES ('#{name}')
        UNION
        SELECT patron FROM characters, children
        WHERE characters.name = children.n
        )
        SELECT name, patron FROM characters
        WHERE characters.name
          IN children AND characters.server = '#{server}';
      QUERY

      patron_result = database.fetch(patron_query).to_a

      if (patron_result.length <= 0)
        raise Exception("TODO")
      end

      patron_result.first[:name]
    end

    def chain(server, root)
      query = <<-QUERY
        WITH RECURSIVE
        children(n) AS (
            VALUES ('#{root}')
          UNION
            SELECT name FROM characters, children
            WHERE characters.patron = children.n
          )
          SELECT name, patron FROM characters
          WHERE characters.name
            IN children AND characters.server = '#{server}';
      QUERY

      database.fetch(query).to_a
    end
  end

  helpers RankingsHelper
end