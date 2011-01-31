class EntriesController < AdminController

  before_filter :load_player, :only => :create

  def index
    @players = Player.all(:include => :entries)
    @years = Contest.years
  end

  def create
    @player.entries.create! :year => params[:year]
    redirect_to entries_path
  end

  private

  def load_player
    @player = Player.find(params[:player_id])
  end

end
