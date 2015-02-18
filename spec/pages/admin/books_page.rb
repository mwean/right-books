module Admin
  class BooksPage < SitePrism::Page
    set_url '/admin/books'
    set_url_matcher(/admin\/books/)

    section :book_search_modal, Admin::BookSearchModalSection, '.modal'
    section :view_filter, Admin::ViewFilterSection, '.select-dropdown'

    elements :books, '.book'
    element :page_title, 'h1'
    element :new_book_button, '.btn--circle__add-book'

    def filter_category(category)
      page_title.hover
      view_filter.click_item(category.name)
    end
  end
end
