class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :team_profile_id

      t.timestamps
    end
    add_index :invitations, :team_profile_id
  end
end
