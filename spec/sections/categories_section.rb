class CategoriesSection < SitePrism::Section
  elements :category_links, 'a'

  def click_category(name)
    category_links.find { |el| el.text.include?(name) }.click
  end
end
