ActiveAdmin.register Department do
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :abbr
    end
    
    f.inputs do
      f.input :courses, as: :check_boxes
    end
    
    f.actions
  end

end
