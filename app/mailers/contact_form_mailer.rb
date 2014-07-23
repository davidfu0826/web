class ContactFormMailer < ActionMailer::Base
    #default to: # my email address

    def contact_email(user, sender_email, questions, answers)
        @user = user
        @sender_email = sender_email
        @questions = questions
        @answers = answers

        mail(from: sender_email, to: user.email, subject: "[TLTH] - Kontaktformulär" )
    end
end
