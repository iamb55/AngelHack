class Registration < ActionMailer::Base
  default from: "Mentor Team <info@mentor.im>"

  def accept(app)
    app.update_attribute(:token, Digest::SHA1.hexdigest(app.email))
    @app = app
    mail(:to => app.email, :bcc => 'info@mentor.im', :subject => 'You\'ve been accepted!')
  end
end
