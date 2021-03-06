Sequel.migration do
  up do
    create_table(:titles) do
      primary_key :id
      foreign_key :character_id, :characters

      # Indices
      index :title_id
      index :character_id

      Integer :title_id, null: false
    end
  end

  down do
    drop_table(:titles)
  end
end
