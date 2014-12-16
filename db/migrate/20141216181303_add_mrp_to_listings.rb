class AddMrpToListings < ActiveRecord::Migration
  def change
    add_column :listings, :mrp, :string
  end
end
