# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
tares = Album.find_by_name('Bumptious - The Tares Destroyer')
unless tares
  a = Album.new(:name => "Bumptious - The Tares Destroyer", :album_number => 1, :mp3_size => 80, :m4a_size => 398)
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
end

elixirs = Album.find_by_name('Bumptious - Remix Elixirs')
unless elixirs
  a = Album.new(:name => "Bumptious - Remix Elixirs", :album_number => 2, :mp3_size => 80, :m4a_size => 398)
  a.save
  Track.create(:name => 'Spank Rock & Amanda Blank - Bump', :local_name => 'spank_rock', :album => a, :download_count => 0, :track_number => 1)
  Track.create(:name => 'Ruff Ryders - Ride or die', :local_name => 'ruff_ryders', :album => a, :track_number => 2)
  Track.create(:name => 'Mr. Lexx, Santigold & Major Lazer - Hold the line', :local_name => 'major_lazer', :album => a, :track_number => 3)
  Track.create(:name => 'Saigon ft. Albyn J. - Come on baby', :local_name => 'saigon', :album => a, :track_number => 4)
  Track.create(:name => 'Phat Kat ft. Elzhi - Cold Steel', :local_name => 'phat_kat', :album => a, :track_number => 5)
  Track.create(:name => 'Game - Put you on the game', :local_name => 'game', :album => a, :track_number => 6)
  Track.create(:name => 'Raekwon ft. Fat Joe & Ghostface killa - Clientele Kidd', :local_name => 'raekwon', :album => a, :track_number => 7)
  Track.create(:name => 'Obie Trice ft. Busta Rhymes - Oh', :local_name => 'obie_trice', :album => a, :track_number => 8)
  Track.create(:name => 'Slum Village ft. MC Breed - Do you', :local_name => 'slum_village', :album => a, :track_number => 9)
  Track.create(:name => 'Young Jeezy - 22\'s or better', :local_name => 'young_jeezy', :album => a, :track_number => 10)
  Track.create(:name => 'Stat Quo - Like Dat', :local_name => 'stat_quo', :album => a, :track_number => 11)
  Track.create(:name => 'Slim Thug - Diamonds', :local_name => 'slim_thug', :album => a, :track_number => 12)
  Track.create(:name => 'Mobb Deep - Drop a gem on \'em', :local_name => 'mobb_deep', :album => a, :track_number => 13)
  Track.create(:name => 'Fam Lay ft. Pharrell - Da Beeper', :local_name => 'famlay', :album => a, :track_number => 14)
end
unless tares.cc_license
  tares.cc_license = true
  tares.save
end
