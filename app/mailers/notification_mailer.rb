class NotificationMailer < ActionMailer::Base

  def contact_us_notification(name, email, telephone=nil, reason, recipient)
    @name = name
    @email = email
    @telephone = telephone
    @reason = reason
      mail(to: recipient, subject: 'Notification from Contact Us page')
  end
end