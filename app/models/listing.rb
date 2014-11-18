class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :college

  validates :title,   presence: true
  validates :price,   presence: true, numericality: { greater_than: 0 }
  validates :user,    presence: true
  validates :college, presence: true

  extend CarrierWave::Mount
  mount_uploader :image, ImageUploader

  enum quality: { like_new: 0, average_used: 1, heavily_used: 2 }
  enum markings: { no_markings: 0, few: 1, heavily_marked: 2 }

  def serialized_hash(options = {})
    data = {}

    data[:id]            = id
    data[:title]         = title
    data[:description]   = description
    data[:price]         = price
    data[:image]         = {}
    data[:image][:thumb] = image.thumb.url
    data[:quality]       = quality
    data[:markings]      = markings
    data[:edition]       = edition
    data[:torn]          = torn
    data[:sold]          = sold
    data[:created_at]    = created_at

    data[:college]        = {}
    data[:college][:id]   = college.id
    data[:college][:name] = college.name
    data[:college][:abbr] = college.abbr
    data[:college][:city] = college.city

    data[:user]                 = {}
    data[:user][:id]            = user.id
    data[:user][:name]          = user.name
    data[:user][:mobile_number] = user.mobile_number
    data[:user][:role]          = user.role

    data
  end

  private

  def set_college
    self.college = user.college
  end
  before_create :set_college
end
