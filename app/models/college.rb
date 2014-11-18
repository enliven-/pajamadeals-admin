class College < ActiveRecord::Base
  has_many :users
  has_many :listings
  belongs_to :university
  has_and_belongs_to_many :books
end
