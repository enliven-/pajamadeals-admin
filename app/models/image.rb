class Image < ActiveRecord::Base

  belongs_to :book

  extend CarrierWave::Mount
  mount_uploader :name, ImageUploader
end
