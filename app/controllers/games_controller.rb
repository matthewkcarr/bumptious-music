class GamesController < ApplicationController
  
  def cron
    render :action => 'cron', :layout => 'cron'
  end

  def defend
    render :action => :defend, :layout => 'defend'
  end
end
