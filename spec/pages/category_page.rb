class CategoryPage < SitePrism::Page
  set_url '/categories{/slug}'
  set_url_matcher(/categories\/[a-z-]+/)

  elements :books, '.book-grid__book'
end
