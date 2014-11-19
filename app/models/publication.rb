class Publication < ActiveRecord::Base
  has_many :books
end
