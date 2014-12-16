class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file

      t.references :book

      t.timestamps
    end
  end
end
