class CategoriesSection < SitePrism::Section
  elements :category_links, 'a'

  def click_category(name)
    wait_for_category_links

    category_links.find { |el| el.text.include?(name) }.tap do |category_link|
      raise "Browse link for category #{name} was not found" unless category_link

      category_link.click
    end
  end
end
