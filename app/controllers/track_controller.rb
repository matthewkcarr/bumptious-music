class TrackController < ApplicationController
  #require 'action_controller/mime_type' 

  def show
    @album = Album.find_by_album_number(params[:album_id])
    if @album.nil?
      redirect_to '/albums'
    end
    @track = Track.find(:first, :conditions => {:album_id => @album, :track_number => params[:id]})
    @track.transaction do
      @track.download_count = @track.download_count + 1
      @track.download_referer = request.referer
      @track.save
    end
    respond_to do |format|
      format.mp3 {
        dname = ('Bumptious - ' + @track.name) + '.mp3'
        send_file RAILS_ROOT + '/public/music/' + @album.album_number + '/' + @track.local_name + '.mp3', :filename => dname, :type=>"application/force-download"
      }
      format.m4a {
        dname = ('Bumptious - ' + @track.name) + '.m4a'
        send_file RAILS_ROOT + '/public/music/'+ @album.album_number + '/' + @track.local_name + '.m4a', :filename => dname, :type=>"application/force-download"
      }
    end

  end

end
