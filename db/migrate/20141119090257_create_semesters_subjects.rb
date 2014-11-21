class CreateSemestersSubjects < ActiveRecord::Migration
  def change
    create_table :semesters_subjects, id: false do |t|
      t.references :semester
      t.references :subject
    end
  end
end
