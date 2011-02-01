require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  test 'toggle picks editable' do
    login_as_admin
    config = AdminConfig.make(:picks_editable => true)
    assert config.picks_editable
    put :toggle_picks_editable
    assert !config.reload.picks_editable
    put :toggle_picks_editable
    assert config.reload.picks_editable
  end

end
