class UnlockController < ApplicationController
  
  def email 
    @link_hash = (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
    mp3_hash  = (0...24).map{ ('a'..'z').to_a[rand(26)] }.join
    @email = ExtracksEmail.new(:email => params[:five][:email], :link_hash => @link_hash, :mp3_hash => mp3_hash)
    if email.save
      respond_to do |format|
        format.js { render :template => 'show_link'  }
      end
    else
      respond_to do |format|
        format.js { render :partial => 'form'  }
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
