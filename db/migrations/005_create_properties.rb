Sequel.migration do
  up do
    create_table(:properties) do
      primary_key :id
      foreign_key :character_id, :characters

      Integer :property_id, null: false
      Integer :value, null: false
    end
  end

  down do
    drop_table(:properties)
  end
end