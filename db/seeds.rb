# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
a = Album.new(:name => "The tares destroyer", :album_number => 1)
a.save
Track.create(:name => 'Bump', :local_name => 'bump', :album => a, :download_count => 0, :track_number => 1)
Track.create(:name => 'Ride or die', :local_name => 'ride_or_die', :album => a, :track_number => 2)
Track.create(:name => 'Hold the line', :local_name => 'hold_the_line', :album => a, :track_number => 3)
Track.create(:name => 'Come on', :local_name => 'come_on', :album => a, :track_number => 4)
Track.create(:name => 'Sweet seeds', :local_name => 'sweet_seeds', :album => a, :track_number => 5)
Track.create(:name => 'Put you on the word', :local_name => 'on_the_word', :album => a, :track_number => 6)
Track.create(:name => 'Clientele Kidd', :local_name => 'clientele', :album => a, :track_number => 7)
Track.create(:name => 'Oh', :local_name => 'oh', :album => a, :track_number => 8)
Track.create(:name => 'Do you', :local_name => 'do_you', :album => a, :track_number => 9)
Track.create(:name => 'Desolate lands', :local_name => 'desolate_lands', :album => a, :track_number => 10)
Track.create(:name => 'Seed foundations', :local_name => 'seed', :album => a, :track_number => 11)
Track.create(:name => 'Diamonds', :local_name => 'diamonds', :album => a, :track_number => 12)
Track.create(:name => 'Drop a gem on \'em', :local_name => 'drop_gem', :album => a, :track_number => 13)
Track.create(:name => 'The beeper', :local_name => 'the_beeper', :album => a, :track_number => 14)
