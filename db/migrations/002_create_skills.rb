Sequel.migration do
  up do
    create_table(:skills) do
      primary_key :id
      foreign_key :character_id, :characters

      Integer :skill_id, null: false
      Integer :training_id, null: false
      Integer :base
    end
  end

  down do
    drop_table(:skills)
  end
end
