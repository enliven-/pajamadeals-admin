class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.text    :description
      t.string  :price
      t.integer :quality
      t.integer :markings
      t.boolean :torn, default: false
      t.boolean :spam, default: false
      t.boolean :deleted, default: false
      t.boolean :sold, default: false

      t.references :user
      t.references :college
      t.references :book
      t.references :image

      t.timestamps
    end
  end
end
