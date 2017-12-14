class InviteMailer < ApplicationMailer

  def invitation_send(invitation)
    @invitation = invitation
    mail to: @invitation.email, subject: "Invitation E-mail"
  end

end
