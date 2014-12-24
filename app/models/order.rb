class Order < ActiveRecord::Base
  belongs_to :listing
  belongs_to :seller,  class_name: 'User'
  belongs_to :buyer,   class_name: 'User'
  belongs_to :handler, class_name: 'AdminUser'
  belongs_to :seller_college, class_name: 'College'
  belongs_to :buyer_college, class_name: 'College'

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

    data[:listing] = listing.serialized_hash

    data
  end

  #private
  
  before_create :set_seller
  def set_seller
    self.seller = listing.user
  end
  
  before_create :set_college
  def set_college
    self.seller_college = listing.college
    self.buyer_college =  buyer.college
  end

  after_save :set_listing_status
  def set_listing_status
    if cancelled?
      listing.unsold!
    elsif order_placed?
      listing.sold!
    end
  end
  
  after_create :send_notification_to_buyer
  def send_notification_to_buyer
      merge_vars = [
            { name: "name",                content: buyer.name },
            { name: "mobile",              content: buyer.mobile },
            { name: "listing_title",       content: listing.title },
            { name: "listing_publication", content: listing.publication_name },
            { name: "listing_price",       content: listing.price },
            { name: "transaction_cost",    content: App.transaction_cost }
          ]
    
      mandrill = Mandrill::API.new ENV['MANDRILL_APIKEY']
      template_name = "order_notification_for_buyer"
      template_content = []
      message = {
       "from_email"=>"people@pajamadeals.in",
       "from_name"=>"Pajamadeals",
       "to"=>
          [{"email"=>"people@pajamadeals.in",
              "name"=>"Recipient Name",
              "type"=>"to"}],
       "headers"=>{"Reply-To"=>"people@pajamadeals.in"},
       "important"=>false,
       "track_opens"=>nil,
       "track_clicks"=>nil,
       "auto_text"=>nil,
       "auto_html"=>nil,
       "inline_css"=>nil,
       "url_strip_qs"=>nil,
       "preserve_recipients"=>nil,
       "view_content_link"=>nil,
       "tracking_domain"=>nil,
       "signing_domain"=>nil,
       "return_path_domain"=>nil,
       "merge"=>true,
       "global_merge_vars"=> merge_vars
      }

      result = mandrill.messages.send_template template_name, template_content,
                                               message
      result.first["status"]
  end
  
  after_create :send_notification_to_seller
  def send_notification_to_seller
      merge_vars = [
            { name: "name",                content: seller.name },
            { name: "mobile",              content: seller.mobile },
            { name: "listing_title",       content: listing.title },
            { name: "listing_publication", content: listing.publication_name },
            { name: "listing_price",       content: listing.price }
          ]
    
      mandrill = Mandrill::API.new ENV['MANDRILL_APIKEY']
      template_name = "order_notification_for_seller"
      template_content = []
      message = {
       "from_email"=>"people@pajamadeals.in",
       "from_name"=>"Pajamadeals",
       "to"=>
          [{"email"=>"people@pajamadeals.in",
              "name"=>"Recipient Name",
              "type"=>"to"}],
       "headers"=>{"Reply-To"=>"people@pajamadeals.in"},
       "important"=>false,
       "track_opens"=>nil,
       "track_clicks"=>nil,
       "auto_text"=>nil,
       "auto_html"=>nil,
       "inline_css"=>nil,
       "url_strip_qs"=>nil,
       "preserve_recipients"=>nil,
       "view_content_link"=>nil,
       "tracking_domain"=>nil,
       "signing_domain"=>nil,
       "return_path_domain"=>nil,
       "merge"=>true,
       "global_merge_vars"=> merge_vars
      }

      result = mandrill.messages.send_template template_name, template_content,
                                               message
      result.first["status"]
  end
end
