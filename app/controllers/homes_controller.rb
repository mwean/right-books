class HomesController < ApplicationController
  FEATURED_CATEGORY_KEYS = %w(history biography philosophy economics culture)
  CATEGORY_SECTION_KEYS  = %w(culture philosophy essentials)

  def index
    @new_releases = Book.new_releases(6)
  end

  protected

  def featured_categories
    filter_categories(FEATURED_CATEGORY_KEYS)
  end

  def category_sections
    filter_categories(CATEGORY_SECTION_KEYS).map(&CategorySection.method(:new))
  end

  def all_categories
    Category.by_key((FEATURED_CATEGORY_KEYS + CATEGORY_SECTION_KEYS).uniq).load
  end

  def filter_categories(included_category_keys)
    all_categories.select { |category| category.key.in?(included_category_keys) }
  end

  helper_method :featured_categories, :category_sections
end
