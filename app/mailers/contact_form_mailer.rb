class ContactFormMailer < ActionMailer::Base
    default from: "info@tlth.se"

  def contact_email(user, sender_email, questions, answers, title)
      @user = user
      @sender_email = sender_email
      @questions = questions
      @answers = answers
      @title = title

      mail(to: user.email, subject: "[TLTH] - Kontaktformulär - #{title}" )
  end
end
