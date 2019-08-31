Sequel.migration do
  up do
    create_table(:characters) do
      primary_key :id

      String :server, null: false
      String :name, null: false
      String :account_name
      FalseClass :archived, default: false

      Integer :race_id, null: false
      Integer :gender_id, null: false
      Integer :level
      Integer :current_title
      DateTime :birth
      Integer :deaths
      Numeric :total_xp
      Numeric :unassigned_xp
      Numeric :luminance_total
      Numeric :luminance_earned
      Integer :skill_credits

      # Allegiance
      String :allegiance_name
      Integer :rank
      Integer :followers
      Integer :monarch_id
      Integer :patron_id

      # Attributes
      Integer :strength_creation
      Integer :strength_base
      Integer :endurance_creation
      Integer :endurance_base
      Integer :coordination_creation
      Integer :coordination_base
      Integer :quickness_creation
      Integer :quickness_base
      Integer :focus_creation
      Integer :focus_base
      Integer :self_creation
      Integer :self_base

      # Vitals
      Integer :health_base
      Integer :stamina_base
      Integer :mana_base

      timestamp :created_at
      timestamp :updated_at
    end
  end

  down do
    drop_table(:characters)
  end
end