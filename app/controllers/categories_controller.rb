class CategoriesController < AdminController
  
  def index
    @categories = Category.all(:include => :nominees)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    Category.create!(params[:category])
    redirect_to categories_path
  end
  
  def edit
    @category = Category.find params[:id]
  end
  
  def update
    @category = Category.find(params[:id])
    @category.update_attributes! params[:category]
    redirect_to categories_path
  end
  
end
