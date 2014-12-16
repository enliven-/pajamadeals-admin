class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :authors
      t.string :mrp

      t.references :university
      t.references :department
      t.references :course
      t.references :semester
      t.references :subject
      t.references :publication

      t.timestamps
    end
  end
end
