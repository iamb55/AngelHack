class Registration < ActionMailer::Base
  default from: "Mentor Team <info@mentor.im>"

  def accept(app)
    app.update_attribute(:token, Digest::SHA1.hexdigest(app.email))
    @app = app
    mail(:to => app.email, :bcc => 'info@mentor.im', :subject => 'You\'ve been accepted!')
  end

  def mentee_accept(mentee_app)
    mentee_app.update_attribute(:token, Digest::SHA1.hexdigest(mentee_app.email))
    @mentee_app = mentee_app
    mail(:to => mentee_app.email, :bcc => 'info@mentor.im', :subject => 'We\'ve found mentors for you!')
  end
end
