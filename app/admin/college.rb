ActiveAdmin.register College do
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :abbr
      f.input :city
      f.input :zipcode
      f.input :latitude
      f.input :longitude
    end
    
    f.inputs do
      f.input :university
    end
    
    f.inputs do
      f.input :departments, as: :check_boxes
    end
    f.actions
  end
end