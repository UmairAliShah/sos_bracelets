class AddLeaderIdToTeamProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :team_profiles, :leader_id, :integer
    add_index :team_profiles, :leader_id
  end
end
