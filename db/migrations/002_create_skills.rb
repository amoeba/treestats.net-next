Sequel.migration do
  up do
    create_table(:skills) do
      primary_key :id
      foreign_key :character_id, :characters
      id :skill_id, null: false
      id :training_id, null: false
    end
  end

  down do
    drop_table(:skills)
  end
end