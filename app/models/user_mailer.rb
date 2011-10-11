class UserMailer < ActionMailer::Base

  def welcome_email(user)
    recipients    user.email
    from          "Dialogue Admin <dialogue.admin@ptotem.com>"
    subject       "Welcome to Dialogue"
    sent_on       Time.now
    body          :user => user
    content_type  "text/html"
  end

end
