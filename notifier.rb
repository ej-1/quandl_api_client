require 'action_mailer'

class Notifier < ActionMailer::Base
  default from: 'erikwjonsson@gmail.com'

  def welcome(recipient, body)
    @recipient = recipient
    mail(to: recipient,
         subject: "ROI and max drawdown calculations!",
         body: body.to_s
         )
  end
end
