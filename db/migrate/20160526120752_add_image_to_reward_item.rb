class AddImageToRewardItem < ActiveRecord::Migration
  def change
    add_column :reward_item, :image, :string
  end
end
