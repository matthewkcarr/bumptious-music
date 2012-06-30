class AlbumController < ApplicationController

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
