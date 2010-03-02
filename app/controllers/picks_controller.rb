class PicksController < ApplicationController
  
  before_filter :load_player
  before_filter :load_categories
  
  def index
    
  end
  
  def edit
    
  end
  
  def update
    @player.picks_attributes = params[:picks]
    @player.save!
    redirect_to player_picks_url(@player)
  end
  
  private
  
  def load_player
    @player = Player.find(params[:player_id], :include => :picks) if params[:player_id]
  end
  
  def load_categories
    @categories = Category.all(:include => :nominees)
  end
  
end
