class Invitation < ApplicationRecord
  validates :email, presence: true

  belongs_to :team_profile


  after_create :invitation_send
  def invitation_send
    InviteMailer.invitation_send(self).deliver
  end
end
