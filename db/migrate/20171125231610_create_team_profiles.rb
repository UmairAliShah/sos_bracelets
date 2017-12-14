class CreateTeamProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :team_profiles do |t|
      t.string :name
      t.string :city
      t.integer :zip
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
