class BookPage < SitePrism::Page
  set_url '/books{/slug}'
  set_url_matcher(/books\/[a-z-]+/)

  element :cover_image, '.book-cover'
end
