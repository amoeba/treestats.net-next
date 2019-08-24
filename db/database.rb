migration "create the characters table" do
  database.create_table :characters do
    primary_key :id
    text        :name
    text        :server
    text        :level
  end
end

migration "create the skills table" do
  database.create_table :skills do
    primary_key :id
    foreign_key :character_id
    id        :skill_id
    id        :training_id
  end
end