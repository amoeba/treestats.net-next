# frozen_string_literal: true

module Sinatra
  module QueryHelper
    def ultimate_patron(id)
      patron_query = <<-QUERY
        WITH RECURSIVE
        children(n) AS (
          VALUES (#{id})
          UNION
          SELECT patron_id FROM characters, children
          WHERE characters.id = children.n
        )
        SELECT id, name, patron_id FROM characters
        WHERE characters.id IN (select * from children) AND patron_id IS NULL;
      QUERY

      patron_result = DB.fetch(patron_query).to_a

      if patron_result.length <= 0
        raise Exception("TODO")
      end

      patron_result.first[:id]
    end

    def chain(id)
      query = <<-QUERY
        WITH RECURSIVE
        children(x) AS (
          VALUES (#{id})
          UNION
          SELECT id FROM characters, children
          WHERE characters.patron_id = children.x
        )
        SELECT id, name, patron_id FROM characters
        WHERE characters.id IN (select * from children);
      QUERY

      DB.fetch(query).to_a
    end

    def populations
      query = <<-QUERY
        SELECT
         server_id as id,
         max(count) as count,
         date(created_at) as date
        FROM populations
        GROUP BY
          date(created_at),
          server_id
        ORDER BY
          id,
          date;
      QUERY

      DB.fetch(query).to_a
    end
  end

  helpers QueryHelper
end
