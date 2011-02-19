class HomeController < ApplicationController

  def index
    @album = Album.first
    @tracks = Track.all(:order => 'track_number')
  end

  def notified 
    FanEmail.create(:email => params[:notified][:email])
    respond_to do |format|
      format.js { render :json => "Great, thanks!"  }
      format.html { redirect_to "/"}
    end
  end

  def message_us 
    message = params[:message]
    session[:email] = message[:email]
    Message.message_us(message).deliver
    respond_to do |format|
      format.js { render :json => "Thanks"  }
      format.html { redirect_to "/"}
    end
  end

  def counts
    ret = Array.new
    @tracks = Track.all
    @tracks.each do |track|
      ret[track.id] = number_with_delimiter(track.download_count)
    end
    respond_to do |format|
      format.js { render :json => ret  }
    end
  end

  def downloaded
    ret = ''
    track = params[:id]
    if track.include?('all') 
      @tracks = Track.all
      @tracks.each do |track|
        track.download_count = track.download_count + 1
        track.save
      end
    else
      @track = Track.find(track)
      @track.download_count = @track.download_count + 1
      @track.save
      ret = number_with_delimiter(@track.download_count)
    end
    respond_to do |format|
      format.js { render :json => { :downloads => ret } }
    end
  end

  private
  def number_with_delimiter(number, options = {})
    options.symbolize_keys!
    begin
      Float(number)
    rescue ArgumentError, TypeError
      if options[:raise]
        raise InvalidNumberError, number
      else
        return number
      end
    end

    defaults = I18n.translate(:'number.format', :locale => options[:locale], :default => {})
    options = options.reverse_merge(defaults)

    parts = number.to_s.split('.')
    parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")
    parts.join(options[:separator]).html_safe
  end
end
