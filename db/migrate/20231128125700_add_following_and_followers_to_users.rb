class AddFollowingAndFollowersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :followers, :integer, default: 0
    add_column :users, :following, :integer, default: 0
  end
end
