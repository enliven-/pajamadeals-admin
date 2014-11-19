class University < ActiveRecord::Base

  has_many :books
  has_many :colleges
end
