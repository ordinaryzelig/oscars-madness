class CategoriesController < AdminController

  skip_before_filter :authenticate_admin, :only => :show
  before_filter :authenticate, :only => :show
  before_filter :load_contest_year

  def show
    @category = Category.find(params[:id], :include => [:nominees => {:picks => [:player, :nominee]}])
    @picks = @category.picks
  end

  def index
    @categories = Category.for_year(contest_year).all(:include => :nominees)
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
