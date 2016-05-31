class AddImageToRewardItem < ActiveRecord::Migration
  def change
    add_column :reward_item, :image, :text
  end
end
