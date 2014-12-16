class CreateCoursesDepartments < ActiveRecord::Migration
  def change
    create_table :courses_departments, id: false do |t|
      t.references :course
      t.references :department
    end
  end
end
