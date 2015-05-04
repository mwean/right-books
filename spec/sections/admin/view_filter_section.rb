module Admin
  class ViewFilterSection < SitePrism::Section
    elements :items, 'td a'

    def click_item(name)
      items.find { |el| el.text.include?(name) }.tap do |item|
        raise "View filter item #{name} was not found" unless item

        item.click
      end
    end
  end
end
