class Book < ActiveRecord::Base
  has_and_belongs_to_many :universities
  has_and_belongs_to_many :colleges
  has_and_belongs_to_many :departments
  has_and_belongs_to_many :academic_years
  has_and_belongs_to_many :semesters

  has_many :images
end
