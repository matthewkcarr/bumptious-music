class Album < ActiveRecord::Base
  has_many :tracks
  def to_param
    link = self.name.parameterize
    "#{album_number}-#{link}"
  end
end
