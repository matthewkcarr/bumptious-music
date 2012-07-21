class UnlockController < ApplicationController
  
  def download_five
    mp3_hash = params[:mp3_hash]
    @extra = ExtracksEmail.find_by_mp3_hash(mp3_hash)
    unless @extra.nil? or @extra.download_visits > 6
      @extra.download_visits = @extra.download_visits + 1
      @extra.save
      send_file RAILS_ROOT + '/public/music/album/thefive.zip', :filename => 'Bumptious - Remix Elixirs II UK Vs US - Five Tracks Sneak Peak.zip', :type=>"application/force-download" and return
    else
      redirect_to Album.find_by_album_number(2), :status => 301 and return
    end
  end

  def check_hash
    ip = request.remote_ip || "127.0.0.1"
    link_hash = params[:link_hash]
    @extra = ExtracksEmail.find_by_link_hash(link_hash)
    unless @extra.nil?  or @extra.origin_ip == ip
      #begin
      @extra.visited_by = @extra.visited_by + 1
      if @extra.visited_by == 1
        message = @extra.email + " has unlocked five tracks. "
        message = message + "Visit the following link to download the new tracks. "
        message = message + '<a href="' + download_five_url( @extra.mp3_hash ) + '">'
        message = message + download_five_url( @extra.mp3_hash ) + '</a>'
        Message.unlocked(message).deliver
      end
      @extra.save
    end
    redirect_to Album.find_by_album_number(2), :status => 301
  end

  def email 
    ip = request.remote_ip || "127.0.0.1"
    @link_hash = (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
    mp3_hash  = (0...24).map{ ('a'..'z').to_a[rand(26)] }.join
    @email = ExtracksEmail.new(:email => params[:extracks_email][:email], :link_hash => @link_hash, :mp3_hash => mp3_hash, :origin_ip => ip)
    if @email.save
      respond_to do |format|
        format.js { render :template => 'unlock/show_download_link'  }
      end
    else
      respond_to do |format|
        format.js { render :template => 'unlock/show_need_email'  }
      end
    end
  end

  def fivemore 
    respond_to do |format|
      format.js 
    end
  end

  def fan_shbam
    ip = request.remote_ip || "127.0.0.1"
    ip = "24.23.6.223" if ip == "127.0.0.1"
    @guser = Geokit::Geocoders::MultiGeocoder.geocode(ip)
    @fan_location = FanLocation.new(:city => @guser.city, :state => @guser.state, :country_code => @guser.country_code, :ip_address => ip)
    @fan_location.save
    @top_three = FanLocation.top_three
    ret = Array.new
    i = 0
    @top_three.each do |top| 
      ret[i] = top
      i = i + 1
    end
    #@tracks = Track.all
    #@tracks.each do |track|
    #  ret[track.id] = number_with_delimiter(track.download_count)
    #end
    respond_to do |format|
      format.js { render :json => ret  }
    end
  end

  def new_fan_shbam
    @newest_three = FanLocation.top_three
    ret = Array.new
    i = 0
    @newest_three.each do |n| 
      ret[i] = n
      i = i + 1
    end
    respond_to do |format|
      format.js { render :json => ret  }
    end
  end

end
