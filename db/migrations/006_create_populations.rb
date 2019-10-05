Sequel.migration do
  up do
    create_table(:populations) do
      primary_key :id

      Integer :server_id, null: false
      Integer :count, null: false
      timestamp :created_at, null: false
    end
  end

  down do
    drop_table(:populations)
  end
end
