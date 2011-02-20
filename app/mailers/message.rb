class Message < ActionMailer::Base
  default :from => "matt@bumptiousmusic.com"
  def message_us(data)
    @content = data
    mail(:from => 'matt@bumptiousmusic.com', 
         :to => 'matt@bumptiousmusic.com',
         :reply => data[:email],
         :subject => "A fan sent you a message")
  end
end
