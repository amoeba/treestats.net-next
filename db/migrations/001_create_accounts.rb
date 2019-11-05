Sequel.migration do
  up do
    create_table(:accounts) do
      primary_key :id

      # Indices
      index :name

      String :name, null: false
    end
  end

  down do
    drop_table(:accounts)
  end
end
