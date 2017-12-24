class AddTeamProfileIdToLeader < ActiveRecord::Migration[5.1]
  def change
    add_column :leaders, :team_profile_id, :integer
    add_index :leaders, :team_profile_id
  end
end
