class AddTeamIdToTeamProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :team_profiles, :team_id, :integer
    add_index  :team_profiles, :team_id
  end
end
