class AddDisabledToShares < ActiveRecord::Migration
  def change
    add_column :shares, :disabled, :boolean
  end
end
