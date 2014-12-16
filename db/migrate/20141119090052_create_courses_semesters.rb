class CreateCoursesSemesters < ActiveRecord::Migration
  def change
    create_table :courses_semesters, id: false do |t|
      t.references :course
      t.references :semester
    end
  end
end
