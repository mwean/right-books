module Admin
  class BookSearchModalSection < SitePrism::Section
    element :search_field, 'input.new-book__search-field'
    elements :results, 'li.search-result'
  end
end
