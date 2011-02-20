class Message < ActionMailer::Base
  default :from => "matt@bumptiousmusic.com"
  def message_us(data)
    @content = data
    mail( :reply => data[:email],
         :subject => "A fan sent you a message")
  end
end
