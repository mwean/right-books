category_info = [
  [:fiction, 'Fiction'],
  [:history, 'History'],
  [:biography, 'Biography & Memoir'],
  [:philosophy, 'Political Philosophy'],
  [:culture, 'Culture'],
  [:economics, 'Economics'],
  [:essentials, 'Essentials']
]

category_info.each do |key, name|
  Category.where(key: key).first_or_create(name: name)
end
