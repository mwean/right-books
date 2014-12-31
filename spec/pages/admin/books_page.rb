module Admin
  class BooksPage < SitePrism::Page
    set_url '/admin/books'
    set_url_matcher(/admin\/books/)

    section :book_search_modal, Admin::BookSearchModalSection, '.modal'

    elements :books, '.book'
    element :new_book_button, '.new-book__btn'
  end
end
