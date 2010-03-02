class HomeController < ApplicationController
  
  def index
    @players = Player.all(:include => :picks)
  end
  
end
