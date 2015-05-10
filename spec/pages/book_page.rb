class BookPage < SitePrism::Page
  set_url '/books{/slug}'
  set_url_matcher(%r{books/[a-z-]+})

  section :comments, CommentsSection, 'comments-section'

  element :cover_image, '.book-cover'
end
