class InviteMailer < ApplicationMailer

  def invitation_send(invitation)
    @invitation = invitation
    if @invitation != nil && @invitation.email != ""
      mail to: @invitation.email, subject: "Invitation E-mail"
    end
  end

end
