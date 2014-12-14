class Publication < ActiveRecord::Base
  default_scope { order('name ASC') }
  has_many :books
end
