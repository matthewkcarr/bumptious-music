class AlbumController < ApplicationController

ART_PICS = [ 
              "ahat.jpg",
              "at_beachx4.jpg",
              "athena_sculpt.jpg",
              "bathraf.jpg",
              "bhind_bike.jpg",
              "canvas_in_church.jpg",
              "cathedral_greece.jpg",
              "charc_street.jpg",
              "charcart.jpg",
              "cow_equality.jpg",
              "cross_arms.jpg",
              "cut_art.jpg",
              "death.jpg",
              "delphi_church.jpg",
              "fotoman.jpg",
              "gecko_strtart.jpg",
              "graf_ltbulb.jpg",
              "greece_drugs.jpg",
              "greece_trucolumns.jpg",
              "greek_ninja.jpg",
              "hat_rabies.jpg",
              "humping.jpg",
              "charc_street2.jpg",
              "inside_the_inside.jpg",
              "joker_greece.jpg",
              "justdoitgree.jpg",
              "memama.jpg",
              "mgraf_ath.jpg",
              "molotov_streetart.jpg",
              "msart.jpg",
              "mtart.jpg",
              "muse.jpg",
              "near_patras_4x.jpg",
              "old_grammaphone.jpg",
              "parthenon.jpg",
              "parthenon2.jpg",
              "pay_money_to_churches.jpg",
              "pic_hosteler.jpg",
              "prabbit.jpg",
              "punk_death_gree.jpg",
              "purple_thinker.jpg",
              "rats.jpg",
              "road_curvex5.jpg",
              "robes_art.jpg",
              "search_peace.jpg",
              "sgraf.jpg",
              "shitty_start.jpg",
              "skate_or_die.jpg",
              "skull_cross.jpg",
              "slingshot.jpg",
              "spartan_helmet.jpg",
              "street_art_greece.jpg",
              "take_you_pills.jpg",
              "tart.jpg",
              "totally_sweet.jpg",
              "tuxman.jpg",
              "typestore.jpg",
              "uberweird.jpg",
              "whatimabout.jpg",
              "wooden_graven.jpg"
]
  def index
    @albums = Album.all
  end

  def not_found
    redirect_to Album.find_by_album_number(2), :status => 301
  end

  def show
    @album = Album.find_by_album_number(params[:id])
    if @album.nil? 
      @album = Album.first
    end
    @tracks = @album.tracks
    vals = @album.name.split('-')
    @artist = vals[0] || "Artist"
    @album_name = vals[1] || "Album Name"
    @top_three = FanLocation.top_three
    respond_to do |format|
      format.html {
        render :show
      }
      format.zip {
        Track.transaction do
          @tracks.each do |track|
            track.download_count = track.download_count + 1
            track.save
          end
        end
        if params[:id] and params[:id].include?('m4a')
          #dname = 'Bumptious - Remix Elixirs Album LOSSLESS M4U' + '.zip'
          dname = @album.name + ' Album LOSSLESS M4U.zip'
          send_file RAILS_ROOT + '/public/music/album/' + @album.album_number.to_s + '_m4a.zip', :filename => dname, :type=>"application/force-download"
        elsif params[:id] and params[:id].include?('mp3')
          #dname = 'Bumptious - Remix Elixirs Album LOSSY MP3' + '.zip'
          dname = @album.name + ' Album LOSSY MP3.zip'
          send_file RAILS_ROOT + '/public/music/album/' + @album.album_number.to_s + '_mp3.zip', :filename => dname, :type=>"application/force-download"
        end
      }
      format.all {
        render :show
      }
    end

  end

end
