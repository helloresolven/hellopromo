class RenamePublicInShares < ActiveRecord::Migration
  def change
    rename_column :shares, :public, :promoted
  end
end
