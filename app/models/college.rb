class College < ActiveRecord::Base
  has_and_belongs_to_many :departments
  has_many :books
  has_many :orders
  has_many :users
  belongs_to :university

  def serialized_hash(options = {})
    data = {}

    data[:id]   = id
    data[:name] = name
    data[:abbr] = abbr
    data[:city] = city

    data
  end

  searchkick locations: ["location"]
  def search_data
    attributes.merge location: [latitude, longitude]
  end

  def nearest_colleges(distance = '1km')
    College.search('*', where: { location: { near: [latitude, longitude],
                                             within: distance }}).results
  end

end
