class User < ActiveRecord::Base
  has_many :listings
  belongs_to :college
  belongs_to :department
  belongs_to :semester
  has_many :sell_orders, class_name: 'Order', foreign_key: :seller_id
  has_many :buy_orders,  class_name: 'Order', foreign_key: :buyer_id

  validates :name, presence: true
  validates :mobile, presence: true
  validates :college, presence: true

  enum role: { user: 0, admin: 1, ambassador: 2, intern: 3 }

  def orders
    sell_orders + buy_orders
  end
end
