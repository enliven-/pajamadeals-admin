class Listing < ActiveRecord::Base
  default_scope { where(spam: false, deleted: false, sold: false) }

  belongs_to :user
  belongs_to :college
  belongs_to :book
  accepts_nested_attributes_for :book
  belongs_to :image
  has_many :orders

  validates :price,   presence: true, numericality: { greater_than: 0 }
  validates :user,    presence: true
  # validates :college, presence: true, on: :create

  delegate :title, :authors, :mrp, :department, :semester, :subject,
           :publication, to: :book

  extend CarrierWave::Mount
  mount_uploader :image, ImageUploader

  enum quality: { "like new" => 0,
                  "fair" => 1,
                  "heavily used" => 2 }
  enum markings: { "no markings" => 0,
                   "few markings" => 1,
                   "heavily marked" => 2 }

  scope :list, -> { where(spam: false) }

  def serialized_hash(options = {})
    data = {}

    data[:id]            = id
    data[:title]         = title
    data[:description]   = description
    data[:price]         = price
    data[:mrp]           = mrp
    data[:authors]       = authors
    data[:quality]       = quality
    data[:markings]      = markings
    data[:torn]          = torn
    data[:sold]          = sold
    data[:created_at]    = created_at.try(:to_s)

    data[:publication]   = publication.try(:name)

    data[:image]         = {}
    data[:image][:thumb] = image.try(:thumb).try(:url)

    data[:college]        = {}
    data[:college][:id]   = college.id
    data[:college][:name] = college.name
    data[:college][:abbr] = college.abbr
    data[:college][:city] = college.city

    data
  end

  # search

  searchkick

  def search_data
    {
      title:          title,
      authors:        authors,
      subject_name:   subject.name,
      subject_id:     subject.id,
      semester_id:    semester.id,
      department_id:  department.id,
      university_id:  college.university.id,
      college_id:     college.id,
      publication_id: publication.id,
      spam: spam
    }
  end

  private

  before_create :set_college
  def set_college
    self.college = user.college
  end
end
