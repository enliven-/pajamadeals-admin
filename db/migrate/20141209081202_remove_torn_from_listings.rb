class RemoveTornFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :torn
  end
end
