Sequel.migration do
  up do
    create_table(:skills) do
      primary_key :id
      foreign_key :character_id, :characters
      id :skill_id
      id :training_id
    end
  end

  down do
    drop_table(:skills)
  end
end