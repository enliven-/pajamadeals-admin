ActiveAdmin.register Book do
  
  index do
    column :id
    column :title
    column :authors
    
    column :subject
    column :publication
    column :semester
    column :department
    column :college
    
    actions
  end
  
  form html: { multipart: true } do |f|
    f.inputs do
      f.input :title
      f.input :authors
      f.input :mrp, label: 'Price (MRP in Rs)'

      f.has_many :images do |i|
        i.input :file, as: :file
      end
      f.input :publication
      f.input :university
      f.input :college
      f.input :department
      f.input :course
      f.input :semester
      f.input :subject
    end
    f.actions
  end
end
