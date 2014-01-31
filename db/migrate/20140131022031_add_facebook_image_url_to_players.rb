class AddFacebookImageUrlToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :facebook_image_url, :string
  end
end
