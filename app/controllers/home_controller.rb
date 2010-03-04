class HomeController < ApplicationController
  
  def index
    @players = Player.all(:include => :picks)
    @categories = Category.all(:include => {:nominees => :film})
  end
  
end
