require 'csv'

def sanitize(e)
  e.try(:strip).try(:titleize)
end

course = Course.create name: 'Bachelor of Engineering', abbr: 'BE'

# upload books

CSV.foreach("#{Rails.root}/db/book.csv", headers: true) do |row|
  p sanitize(row[0])

  publication = Publication.find_or_create_by(name: sanitize(row[2]))
  department = Department.find_or_create_by(name: sanitize(row[6]))
  semester = Semester.find_or_create_by(name: sanitize(row[8]))
  subject = Subject.find_or_create_by(name: sanitize(row[9]))
  university = University.find_or_create_by(name: sanitize(row[10]))

  book = Book.create title: sanitize(row[0]),
                     authors: sanitize(row[1]),
                     publication: publication,
                     book_type: sanitize(row[3]),
                     mrp: row[5].try(:strip),
                     department: department,
                     subject: subject,
                     university: university,
                     course: Course.first,
                     semester: semester

end

CSV.foreach("#{Rails.root}/db/listing.csv", headers: true) do |row|
  p sanitize(row[0])
  
  if row[7].present?
    college = College.find_or_create_by(name: sanitize(row[8]), university: University.first)
    user = User.find_or_create_by(mobile: row[7].strip, college: college, name: sanitize(row[6]))
    if row[1].present? && user.present?
      listing = Listing.create book_id:  row[1].strip,
                               user:     user,
                               edition:  sanitize(row[2]),
                               quality:  row[3].try(:strip).try(:to_i),
                               markings: row[4].try(:strip).try(:to_i),
                               price:    ((row[5].try(:to_i) || 0)*0.55).round.to_s                     
     end
   end
end
