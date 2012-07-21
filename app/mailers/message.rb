class Message < ActionMailer::Base
#  default :from => "matt@bumptiousmusic.com"
  def message_us(data)
=begin
    @content = data
    mail(:from => 'matt@bumptiousmusic.com', 
         :to => 'matt@bumptiousmusic.com',
         :reply => data[:email],
         :subject => "A fan sent you a message")
=end
     recipients 'matt@bumptiousmusic.com'
     from       "matt@bumptiousmsuic.com"
     subject    "A fan sent you a message"
     body       :content => data
  end

  def unlocked(data)
     recipients 'bikokid@gmail.com'
     from       "bikokid@gmail.com"
     subject    "Five tracks have been unlocked"
     body       :content => data
  end
end
