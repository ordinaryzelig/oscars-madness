require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    login_as_admin
  end
  
  def test_index
    AdminConfig.make
    Category.make
    get :index
    assert_response :success
  end
  
  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    name = 'asdf'
    post :create, :category => {:name => name, :points => 1}
    assert_equal name, Category.first.name
  end
  
  def test_edit
    category = Category.make
    get :edit, :id => category
    assert_response :success
  end
  
  def test_update
    category = Category.make
    new_name = category.name.reverse
    put :update, :id => category, :category => {:name => new_name}
    assert_equal new_name, Category.find(category).name
  end
  
end
