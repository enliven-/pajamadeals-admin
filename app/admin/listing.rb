ActiveAdmin.register Listing do
  controller do
    actions :all, except: [:destroy]
  end
 
  index do
    column :id
    column :book
    column :edition
    column :price
    column :sold
    column :spam
  
    
    column "Image" do |listing|
      image_tag(listing.image.file.thumb.url.try(:html_safe)) if listing.image
    end
    
    actions
  end
end
