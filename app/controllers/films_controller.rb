class FilmsController < AdminController
  
  def index
    @films = Film.all(:include => :nominations)
  end
  
  def new
    @film = Film.new
  end
  
  def create
    film = Film.create!(params[:film])
    redirect_to films_path
  end
  
  def edit
    @film = Film.find(params[:id])
  end
  
  def update
    @film = Film.find(params[:id])
    @film.update_attributes! params[:film]
    redirect_to films_path
  end
  
end
