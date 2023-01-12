class MessagesController < ApplicationController
  def holiday_mailer
    amount       = params[:amount]
    sender       = params[:sender]
    sender_email = params[:sender_email]
    name         = params[:honoree]
    email        = params[:honoree_email]
    message      = params[:message]

    @message = Messenger.new(name: name,
                             email: email,
                             message: message)

    if @message.valid?
      HolidayMailer.holiday_message(@message, amount, sender, sender_email).deliver
      redirect_to root_path,
                  notice: 'Your donation has been received and your gift card is being processed, you will be notified once the card is delivered thank you.'
    end
  end

  private

  def message_params
    params.require(:new_message).permit(
      :name,
      :email,
      :message
    )
  end
end
