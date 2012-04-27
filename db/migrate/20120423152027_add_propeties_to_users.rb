class AddPropetiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
  end
end
