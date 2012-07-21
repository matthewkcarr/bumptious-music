class ExtracksEmail < ActiveRecord::Base
  validates_presence_of :email, :link_hash, :mp3_hash
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'is not a valid email address'

  HUMANIZED_ATTRIBUTES = {
    :email => "Your Email"
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
