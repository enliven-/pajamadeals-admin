class AddBuyerCollegeToOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :college_id, :seller_college_id
    add_column :orders, :buyer_college_id, :integer
  end
end
