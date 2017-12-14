class AddTeamIdToLeader < ActiveRecord::Migration[5.1]
  def change
    add_column :leaders, :team_id, :integer
    add_index :leaders, :team_id
  end
end
