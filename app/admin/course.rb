ActiveAdmin.register Course do
  form do |f|
    f.inputs do
      f.input :name
      f.input :abbr
    end
    
    f.inputs do
      f.input :semesters, as: :check_boxes
    end
    f.actions
  end    
end
