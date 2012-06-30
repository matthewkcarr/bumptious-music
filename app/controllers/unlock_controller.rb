class UnlockController < ApplicationController
  
  def fan_shbam
    ip = request.remote_ip || "127.0.0.1"
    ip = "24.23.6.223" if ip == "127.0.0.1"
    @guser = Geokit::Geocoders::MultiGeocoder.geocode(ip)
    @fan_location = FanLocation.new(:city => @guser.city, :state => @guser.state, :country_code => @guser.country_code, :ip_address => ip)
    @fan_location.save
    @top_three = FanLocation.top_three
    ret = Array.new
    i = 0
    y @top_three
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

end
