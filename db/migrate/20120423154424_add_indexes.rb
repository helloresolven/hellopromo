class AddIndexes < ActiveRecord::Migration
  def change
    add_index :redeemables, :redeemer_id
    add_index :shares, :owner_id
    add_index :users, :uid
  end
end
