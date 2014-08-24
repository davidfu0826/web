class UserMailer < ActionMailer::Base
  default from: "info@tlth.se"

  def password_reset(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "Välkommen till TLTH.se" )
  end
end
