class AddAttachmentAvatarToTeamProfiles < ActiveRecord::Migration[5.1]
  def self.up
    change_table :team_profiles do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :team_profiles, :avatar
  end
end
