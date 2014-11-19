class College < ActiveRecord::Base
  has_and_belongs_to_many :departments
  has_many :books
  belongs_to :university
end
