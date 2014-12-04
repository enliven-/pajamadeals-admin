class Order < ActiveRecord::Base
  belongs_to :listing
  belongs_to :college
  belongs_to :seller,  class_name: 'User'
  belongs_to :buyer,   class_name: 'User'
  belongs_to :handler, class_name: 'AdminUser'

  enum status: {
                "order placed"     => 0,
                "handler assigned" => 1,
                "seller confirmed" => 2,
                "buyer confirmed"  => 3,
                "item picked"      => 4,
                "item delivered"   => 5,
                "payment pending"  => 6,
                "cancelled"        => 7
               }

  def order_placed?
    status == "order placed"
  end

  def handler_assigned?
    status == "handler assigned"
  end

  def serialized_hash(options = {})
    data = {}

    data[:id]                  = id
    data[:handler_assigned_at] = handler_assigned_at.try(:to_s)
    data[:seller_confirmed_at] = seller_confirmed_at.try(:to_s)
    data[:item_picked_at]      = item_picked_at.try(:to_s)
    data[:status]              = status
    data[:created_at]          = created_at.to_s
    data[:updated_at]          = updated_at.to_s

    data[:listing]         = {}
    data[:listing][:id]    = listing.id
    data[:listing][:title] = listing.title

    data
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
