class AlbumController < ApplicationController
  Mime::Type.register 'application/mpeg', :mp3
  Mime::Type.register 'application/mpeg', :m4u

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
      format.mp3 {
        dname = 'Bumptious - Remix Elixirs Album AAC' + '.zip'
        send_file RAILS_ROOT + '/public/music/album/remix_elixir_aac.zip', :filename => dname, :type=>"application/force-download"
      }
      format.m4u {
        dname = 'Bumptious - Remix Elixirs Album MP3' + '.zip'
        send_file RAILS_ROOT + '/public/music/album/remix_elixir_mp3.zip', :filename => dname, :type=>"application/force-download"
      }
    end

  end

end
