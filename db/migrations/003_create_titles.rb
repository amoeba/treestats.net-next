Sequel.migration do
  up do
    create_table(:titles) do
      primary_key :id
      foreign_key :character_id, :characters
      id :title_id
    end
  end

  down do
    drop_table(:titles)
  end
end