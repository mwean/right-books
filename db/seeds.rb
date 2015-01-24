categories = [
  'Fiction',
  'History',
  'Biography & Memoir',
  'Political Philosophy',
  'Culture',
  'Economics',
  'Essentials'
]

categories.each do |category|
  Category.find_or_create_by(name: category)
end
