class User < ActiveRecord::Base
  has_many :listings
  belongs_to :college

  validates :name, presence: true
  validates :mobile_number, presence: true
  validates :college, presence: true

  enum role: { user: 0, admin: 1, ambassador: 2, intern: 3 }
end
