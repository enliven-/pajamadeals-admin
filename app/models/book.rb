class Book < ActiveRecord::Base
  belongs_to :university
  belongs_to :college
  belongs_to :department
  belongs_to :course
  belongs_to :semester
  belongs_to :subject
  belongs_to :publication

  has_many :images
  accepts_nested_attributes_for :images
  has_many :listings

  def serialized_hash
    data = {}

    data[:id]          = id
    data[:title]       = title
    data[:authors]     = authors
    data[:mrp]         = mrp
    data[:department]  = department.name
    data[:course]      = course.name
    data[:semester]    = semester.name
    data[:subject]     = subject.name
    data[:publication] = publication.name
    data[:university]  = university.name

    data
  end
end
