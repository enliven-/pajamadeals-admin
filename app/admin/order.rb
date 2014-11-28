ActiveAdmin.register Order do

  controller do
    actions :all, except: [:destroy]
  end
  
  index do    
    column "Listing" do |order|
      line = ''.html_safe
      line += content_tag(:div) { link_to order.listing.title, listing_path(order.listing) }
      line += content_tag(:div) { "Price: Rs. " + order.listing.price }
      line
    end
    column "Seller" do |order|
      line = ''.html_safe
      line += content_tag(:div) { link_to order.seller.name, user_path(order.seller) }
      line += content_tag(:div) { "+91 " + order.seller.mobile }
      line
    end
    column "Buyer" do |order|
      line = ''.html_safe
      line += content_tag(:div) { link_to order.buyer.name, user_path(order.buyer) }
      line += content_tag(:div) { "+91 " + order.buyer.mobile }
      line
    end
    column :handler
    
    column(:status) do |record|
      case record.status
      when 'order placed'
        status_tag("No Handler", "red")
      when 'item delivered'
        status_tag("completed" ,"ok")
      when 'cancelled'
        status_tag("cancelled")
      else
        status_tag(record.status, "orange")
      end
    end
    column :created_at
    
    actions
  end
  
  filter :college
  filter :handler
  filter :status, as: :select, collection: Order.statuses.keys
  filter :created_at

end
