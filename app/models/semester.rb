class Semester < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :subjects
  has_many :books
  has_many :users
end
