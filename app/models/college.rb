class College < ActiveRecord::Base
  has_and_belongs_to_many :departments
  has_many :books
  has_many :orders
  has_many :users
  belongs_to :university
end
