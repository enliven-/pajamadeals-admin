ActiveAdmin.register Order do

  controller do
    actions :all, except: [:destroy]
    
    def update
      status = params[:order][:status]
      order = Order.find(params[:id])
      attribute = (status + ' at').gsub(/\s+/, '_').to_sym
      params[:order][attribute] = Time.now if order.respond_to?(attribute)
      super
    end
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
    actions defaults: true do |order|
      if !order.handler_assigned?
        link_to 'Assign to Yourself', order_path(order, order: { handler_id: current_admin_user.id, status: 'handler assigned' } ), method: :put
      else
        link_to 'Unassign', order_path(order, order: { handler_id: nil, status: 'order placed' } ), method: :put
      end
    end
  end
  
  filter :college
  filter :handler
  filter :status, as: :select, collection: Order.statuses.keys
  filter :created_at
  
  form do |f|
    f.inputs do 
      f.input :status, as: :select, collection: Order.statuses.keys, include_blank: false
      f.input :seller_meeting_at, as: :datetime_picker
      f.input :buyer_meeting_at, as: :datetime_picker
      f.input :item_picked_at, as: :datetime_picker
      f.input :item_delivered_at, as: :datetime_picker
    end
    
     f.inputs do 
      f.input :payment_deposited
      f.input :payment_deposited_at, as: :datetime_picker
    end

    f.actions
  end
  
  show do
    attributes_table do
      row :created_at
      row(:status) do |record|
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
      row :listing
      row "Price" do |order|
        order.listing.price
      end
      row :seller
      row "Contact (seller)" do |order|
        order.seller.mobile
      end
      row :buyer
      row "Contact (buyer)" do |order|
        order.buyer.mobile
      end
      
      row :seller_meeting_at
      row :buyer_meeting_at
      row "payment_deposited" do |order|
        order.payment_deposited? ? status_tag("Yes") : status_tag("No")
      end
    end
  end

end
