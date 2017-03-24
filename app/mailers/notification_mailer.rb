class NotificationMailer < ActionMailer::Base
  default from: 'CertifiedPeng <hello@certifiedpeng.com>'

  def contact_us_notification(options, recipient)
    @name = options[:name]
    @email = options[:email]
    @telephone = options[:telephone]
    @message = options[:message]
    @reason = options[:reason]
      mail(to: recipient, subject: 'Notification from Contact Us page')
  end

  def confirmation_email(email, name)
    @from = 'Certified Peng Analytics <hello@certifiedpeng.com>'
    @email = email
    @name = name
    mail(from: @from, to: email, subject: 'Confirmation email')
  end
end