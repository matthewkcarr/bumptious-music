class Track < ActiveRecord::Base

  belongs_to :album

  def to_param
    link = self.name.parameterize
    "#{track_number}-#{link}"
  end
end
