class CreateRedeemables < ActiveRecord::Migration
  def change
    create_table :redeemables do |t|
      t.string :code
      t.references :share
      t.references :redeemer
      t.timestamps
    end
    add_index :redeemables, :share_id
  end
end
