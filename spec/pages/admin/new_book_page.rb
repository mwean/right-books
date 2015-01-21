module Admin
  class NewBookPage < SitePrism::Page
    set_url '/admin/books/new{?isbn}'
    set_url_matcher(%r{admin/books/new\?isbn=\d+})
  end
end
