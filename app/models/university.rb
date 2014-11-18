class University < ActiveRecord::Base

  has_and_belongs_to_many :books
  has_many :colleges
end
