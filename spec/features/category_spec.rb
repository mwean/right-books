require 'rails_helper'

feature 'category page' do
  given(:category) { create(:category, :with_description, :with_image) }
  given(:category_page) { CategoryPage.new }

  background { category_page.load(slug: category.slug) }

  scenario 'user sees category description and image' do
    expect(category_page.description).to have_content(category.description)
    expect(category_page.image['src']).to have_content(category.image_url)
  end
end
