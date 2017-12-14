class AddTeamProfileIdToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :team_profile_id, :integer
    add_index :profiles, :team_profile_id
  end
end
