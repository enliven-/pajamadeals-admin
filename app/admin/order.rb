ActiveAdmin.register Order do
  config.batch_actions = false
  config.sort_order = "status_asc"
    
  controller do
    actions :all, except: [:destroy, :new]
    
    def scoped_collection
      Order.where(college_id: current_admin_user.college_id).where("status = ? OR handler_id = ?", 0, current_admin_user.id)
    end

    def update
      status = params[:order][:status]
      order = Order.find(params[:id])
      if order.status != status
        attribute = (status + ' at').gsub(/\s+/, '_').to_sym
        params[:order][attribute] = Time.now if order.respond_to?(attribute)
      end
      super do |format|
        redirect_to orders_path and return if resource.valid?
      end
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
    column "Last Updated At", :updated_at
    column :created_at
    actions defaults: true do |order|
      if order.order_placed?
        link_to 'Assign to Yourself', order_path(order, order: { handler_id: current_admin_user.id, status: 'handler assigned' } ), method: :put
      elsif order.handler_assigned?
        link_to 'Unassign', order_path(order, order: { handler_id: nil, status: 'order placed' } ), method: :put
      end
    end
  end

  filter :status, as: :select, collection: Order.statuses.keys
  filter :created_at
  
  form do |f|
    statuses = Order.statuses.keys
    statuses.shift(Order.statuses[f.object.status])
    f.inputs do
      f.input :status, as: :select, collection: statuses, include_blank: false
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
