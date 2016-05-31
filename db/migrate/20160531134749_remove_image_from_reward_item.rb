class RemoveImageFromRewardItem < ActiveRecord::Migration
  def change
    remove_column :reward_item, :Image, :string
  end
end
