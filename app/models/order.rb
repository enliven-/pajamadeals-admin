class Order < ActiveRecord::Base
  belongs_to :listing
  belongs_to :college
  belongs_to :seller,  class_name: 'User'
  belongs_to :buyer,   class_name: 'User'
  belongs_to :handler, class_name: 'AdminUser'

  enum status: {
                "order placed" =>     0,
                "handler assigned" => 1,
                "seller confirmed" => 2,
                "buyer confirmed" =>  3,
                "item picked" =>      4,
                "item delivered" =>   5,
                "payment pending" =>  6,
                "order cancelled" =>  7
               }

  def order_placed?
    status == "order placed"
  end

  def handler_assigned?
    status == "handler assigned"
  end

  private
  before_create :set_college
  def set_college
    self.college = listing.college
  end

  before_create :set_seller
  def set_seller
    self.seller = listing.user
  end
end
