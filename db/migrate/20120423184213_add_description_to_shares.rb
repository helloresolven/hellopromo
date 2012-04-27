class AddDescriptionToShares < ActiveRecord::Migration
  def change
    add_column :shares, :description, :text
    add_column :shares, :description_html, :text
  end
end
