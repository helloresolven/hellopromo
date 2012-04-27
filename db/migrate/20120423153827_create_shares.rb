class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :title
      t.string :url
      t.string :share_code
      t.boolean :need_tweet
      t.boolean :public
      t.references :owner
      
      t.timestamps
    end
  end
end
