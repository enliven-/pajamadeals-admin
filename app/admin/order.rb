ActiveAdmin.register Order do

  controller do
    actions :all, except: [:destroy]
  end
  
  index do    
    column :listing
    column :seller
    column :buyer
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
