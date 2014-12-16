class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.integer :role, default: 0
      t.references :college
      t.references :department
      t.references :semester

      t.timestamps
    end
  end
end
