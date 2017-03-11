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
end