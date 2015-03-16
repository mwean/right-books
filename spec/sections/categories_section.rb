class CategoriesSection < SitePrism::Section
  elements :category_links, 'a'

  def click_category(category)
    category_links.find { |el| el['class'].include?(category.slug) }.tap do |category_link|
      raise "Browse link for category #{category.name} was not found" unless category_link

      category_link.click
    end
  end
end
