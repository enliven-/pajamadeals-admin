class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.datetime :handler_assigned_at
      t.datetime :seller_confirmed_at
      t.datetime :buyer_confirmed_at
      t.datetime :seller_meeting_at
      t.datetime :buyer_meeting_at
      t.datetime :item_picked_at
      t.datetime :item_delivered_at
      t.datetime :cancelled_at
      t.boolean :payment_deposited
      t.datetime :payment_deposited_at

      t.references :listing
      t.references :college
      t.references :seller
      t.references :buyer
      t.references :handler

      t.timestamps
    end
  end
end
