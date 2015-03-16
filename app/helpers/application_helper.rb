module ApplicationHelper
  def category_links(book)
    category_links = book.categories.map do |category|
      link_to(category.name, category_path(category), class: 'small-caps-link')
    end

    category_links.join(', ').html_safe
  end
end
