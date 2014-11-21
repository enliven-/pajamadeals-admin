class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :name
      t.string :abbr
      t.string :city
      t.string :zipcode
      t.string :latitude
      t.string :longitude
      t.integer :university_id

      t.timestamps
    end
  end
end
