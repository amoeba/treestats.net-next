Sequel.migration do
  up do
    create_table(:skills) do
      primary_key :id
      foreign_key :character_id, :characters

      # Indices
      index :character_id
      index :skill_id

      Integer :skill_id, null: false
      Integer :training_id, null: false
      Integer :base, null: false
    end
  end

  down do
    drop_table(:skills)
  end
end
