class CreateCollegesDepartments < ActiveRecord::Migration
  def change
    create_table :colleges_departments, id: false do |t|
      t.references :college
      t.references :department
    end
  end
end
