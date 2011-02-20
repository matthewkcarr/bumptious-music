class AlbumController < ApplicationController

  def show
    @album = Album.find_by_album_number(params[:id])
    @tracks = @album.tracks
    Track.transaction do
      @tracks.each do |track|
        track.download_count = track.download_count + 1
        track.save
      end
    end
    respond_to do |format|
      format.zip {
        if params[:id].include?('m4a')
          dname = 'Bumptious - Remix Elixirs Album LOSSLESS M4U' + '.zip'
          send_file RAILS_ROOT + '/public/music/album/remix_elixir_m4a.zip', :filename => dname, :type=>"application/force-download"
        else
          dname = 'Bumptious - Remix Elixirs Album LOSSY MP3' + '.zip'
          send_file RAILS_ROOT + '/public/music/album/remix_elixir_mp3.zip', :filename => dname, :type=>"application/force-download"
        end
      }
    end

  end

end
