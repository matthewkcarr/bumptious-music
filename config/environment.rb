# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bumptious::Application.initialize!
Mime::Type.register 'audio/mpeg', :mp3
Mime::Type.register 'audio/mp4a-latm', :m4a
Mime::Type.register 'application/zip', :zip

