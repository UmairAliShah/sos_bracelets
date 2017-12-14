class AddAttachmentAvatarToLeaders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :leaders do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :leaders, :avatar
  end
end
