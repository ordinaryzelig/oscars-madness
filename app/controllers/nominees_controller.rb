class NomineesController < AdminController
  
  def new
    @nominee = Nominee.new
  end
  
  def create
    Nominee.create!(params[:nominee])
    redirect_to categories_path
  end
  
  def edit
    @nominee = Nominee.find params[:id]
  end
  
  def update
    @nominee = Nominee.find(params[:id])
    @nominee.update_attributes! params[:nominee]
    redirect_to categories_path
  end
  
end
