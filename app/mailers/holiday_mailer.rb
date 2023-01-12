class HolidayMailer < ApplicationMailer
  default from: 'hello@crowdfrica.org'

  def holiday_message(message, amount, sender, sender_email)
    @message      = message
    @amount       = amount
    @sender       = sender
    @sender_email = sender_email

    # attached_file = "#{Rails.root}/app/assets/images/gift_of_life.png"
    # attachments['gift_of_life.png'] = File.read(attached_file)

    mail(
      to: 'hello@crowdfrica.org',
      subject: "New message from #{@sender.upcase}"
    )
  end
end
