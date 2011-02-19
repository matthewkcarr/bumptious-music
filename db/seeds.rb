# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
a = Album.new(:name => "Remix Elixirs", :album_number => 1)
a.save
Track.create(:name => 'Spank Rock & Amanda Blank - Bump', :local_name => 'spank_rock', :album => a, :download_count => 0, :track_number => 1)
Track.create(:name => 'Ruff Ryders - Ride or die', :local_name => 'ruff_ryders', :album => a, :track_number => 2)
Track.create(:name => 'Mr Lexx,  Santigold & Major Lazer - Hold the line', :local_name => 'major_lazer', :album => a, :track_number => 3)
Track.create(:name => 'Saigon ft. Albyn J. - Come on baby', :local_name => 'saigon', :album => a, :track_number => 4)
Track.create(:name => 'Phat Kat Ft. Elzhi - Cold Steel', :local_name => 'phat_kat', :album => a, :track_number => 5)
Track.create(:name => 'Game - Put you on the game', :local_name => 'game', :album => a, :track_number => 6)
Track.create(:name => 'Raekwon Ft. Fat Joe & Ghostface Killah - Clientele Kidd', :local_name => 'raekwon', :album => a, :track_number => 7)
Track.create(:name => 'Obie trice ft. Busta Rhymes - Oh', :local_name => 'obie_trice', :album => a, :track_number => 8)
Track.create(:name => 'Slum Village ft. Mc Breed - Do you', :local_name => 'slum_village', :album => a, :track_number => 9)
Track.create(:name => 'Young Jeezy - 22\'s or better', :local_name => 'young_jeezy', :album => a, :track_number => 10)
Track.create(:name => 'Stat Quo - Like dat', :local_name => 'stat_quo', :album => a, :track_number => 11)
Track.create(:name => 'Slim Thug - Diamonds', :local_name => 'slim_thug', :album => a, :track_number => 12)
Track.create(:name => 'Mobb Deep - Drop a gem on \'em', :local_name => 'mobb_deep', :album => a, :track_number => 13)
Track.create(:name => 'Fam Lay Ft. Pharrell - Da Beeper', :local_name => 'famlay', :album => a, :track_number => 14)
