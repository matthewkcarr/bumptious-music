class GamesController < ApplicationController
  
  def defend
    render :action => :defend, :layout => 'defend'
  end
end
