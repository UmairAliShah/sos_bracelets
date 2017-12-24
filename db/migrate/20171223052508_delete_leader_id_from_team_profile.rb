class DeleteLeaderIdFromTeamProfile < ActiveRecord::Migration[5.1]

  def change
    remove_column :team_profiles, :leader_id
  end
end
