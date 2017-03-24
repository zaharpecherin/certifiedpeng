class NotificationMailer < ActionMailer::Base
  default from: 'CertifiedPeng <hello@certifiedpeng.com>'

  def contact_us_notification(name, email, telephone=nil, reason, message, recipient)
    @name = name
    @email = email
    @telephone = telephone
    @message = message
    @reason = reason
      mail(to: recipient, subject: 'Notification from Contact Us page')
  end

  def confirmation_email(email, name)
    @from = 'Certified Peng Analytics <hello@certifiedpeng.com>'
    @email = email
    @name = name
    mail(from: @from, to: email, subject: 'Confirmation email')
  end
end