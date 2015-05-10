class CategoryPage < SitePrism::Page
  set_url '/categories{/slug}'
  set_url_matcher(%r{categories/[a-z-]+})

  elements :books, '.book-grid__book'
  element :description, '.category-description'
  element :image, 'img'
end
