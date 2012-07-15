class ExtracksEmail < ActiveRecord::Base
  validates_presence_of :email, :link_hash, :mp3_hash
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
