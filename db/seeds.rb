require 'csv'

def sanitize(e)
  e.try(:strip).try(:titleize)
end

@books = Book.all.map(&:id)
@listings = Listing.all.map(&:id)

# course = Course.create name: 'Bachelor of Engineering', abbr: 'BE'
#
# # upload books
#
CSV.foreach("#{Rails.root}/db/book.csv", headers: true) do |row|
  next if @books.include?(row[0].to_i)
  
  p sanitize(row[1])

  publication = Publication.find_or_create_by(name: sanitize(row[3]))
  department = Department.find_or_create_by(name: sanitize(row[7]))
  semester = Semester.find_or_create_by(name: sanitize(row[9]))
  subject = Subject.find_or_create_by(name: sanitize(row[10]))
  university = University.find_or_create_by(name: sanitize(row[11]))

  book = Book.create id: row[0].to_i,
                     title: sanitize(row[1]),
                     authors: sanitize(row[2]),
                     publication: publication,
                     book_type: sanitize(row[4]),
                     mrp: row[6].try(:strip),
                     department: department,
                     subject: subject,
                     university: university,
                     course: Course.first,
                     semester: semester

end

# images

Dir.foreach("#{Rails.root}/db/books1") do |file|
  next if file == '.' or file == '..'
  id = file.split('-').first.to_i
  p "file: #{file}, id: #{id}"
  book = Book.find id
  image = Image.create file: File.open(File.join(Rails.root, "db", "books1", file)), book: book
end
#
CSV.foreach("#{Rails.root}/db/listing.csv", headers: true) do |row|
  next if @listings.include?(row[0].to_i)
  p sanitize(row[1])

  if row[9].present? && row[2].present?
    college = College.find_or_create_by(name: sanitize(row[10]), university: University.first)
    user = User.find_or_create_by(mobile: row[9].strip, college: college, name: sanitize(row[8]))
    listing = Listing.create id: row[0].strip.to_i,
                             book_id:  row[2].strip,
                             user:     user,
                             edition:  sanitize(row[3]),
                             quality:  row[4].try(:strip).try(:to_i),
                             markings: row[5].try(:strip).try(:to_i),
                             price:    ((row[7].try(:to_i) || 0)*0.50).round.to_s
   end
end
