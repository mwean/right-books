category_info = [
  [:fiction, 'Fiction & Literature'],
  [:history, 'History'],
  [:biography, 'Biography & Memoir'],
  [:philosophy, 'Political Philosophy'],
  [:politics, 'Politics'],
  [:culture, 'Culture'],
  [:current_events, 'Current Events'],
  [:classics, 'Classics'],
  [:conservatism, 'Conservatism'],
  [:religion, 'Religion'],
  [:essentials, 'Essentials']
]

category_info.each do |key, name|
  Category.where(key: key).first_or_create(name: name)
end
