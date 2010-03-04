class HomeController < ApplicationController
  
  def index
    @players = Player.all(:include => :picks).sort
    @categories = Category.all(:include => {:nominees => :film})
  end
  
end
