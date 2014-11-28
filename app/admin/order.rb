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
      when 'created'
        status_tag("created", "red")
      when 'in_process'
        status_tag("In process", "orange")
      when 'completed'
        status_tag("Completed" ,"ok")
      when 'cancelled'
        status_tag("cancelled")
      end
    end
    column :created_at
    
    actions
  end

end
