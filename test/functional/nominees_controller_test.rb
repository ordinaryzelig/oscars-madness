require 'test_helper'

class NomineesControllerTest < ActionController::TestCase

  def setup
    super
    AdminConfig.make
    login_as_admin
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    category = Category.make
    film = Film.make
    name = 'asdf'
    post :create, :nominee => {:name => name, :film_id => film.id, :category_id => category.id}
    assert_equal name, Nominee.first.name
    assert_equal film, Nominee.first.film
    assert_equal category, Nominee.first.category
  end

  def test_edit
    nominee = Nominee.make
    get :edit, :id => nominee
    assert_response :success
  end

  def test_update
    nominee = Nominee.make
    new_name = nominee.name.reverse
    put :update, :id => nominee, :nominee => {:name => new_name}
    assert_equal new_name, Nominee.find(nominee).name
  end

  def test_declare_winner
    nominee = Nominee.make
    put :declare_winner, :id => nominee
    assert nominee.reload.is_winner
    assert_redirected_to root_path
  end

end
