class Order < ActiveRecord::Base
  belongs_to :listing
  belongs_to :college
  belongs_to :seller,  class_name: 'User'
  belongs_to :buyer,   class_name: 'User'
  belongs_to :handler, class_name: 'AdminUser'

  enum status: { created: 0, in_process: 1, completed: 2, canceled: 3 }

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
