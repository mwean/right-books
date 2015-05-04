class CategoriesController < ApplicationController
  helper_method :categories

  def index
  end

  def show
    @category = categories.find { |category| category.slug == params[:id] }
    @books = @category.ordered_books
  end

  def new_releases
    @category = NewReleasesCategory.new
    @books = Book.new_releases

    render 'show'
  end

  private

  def categories
    @categories ||= sort(Category.all + [NewReleasesCategory.new])
  end

  def sort(categories)
    categories.sort_by { |category| category_order.index(category.key) || 999 }
  end

  def category_order
    %w(
      history
      law
      economics
      biography
      philosophy
      politics
      culture
      current_events
      religion
      conservatism
      classics
      fiction
    )
  end
end
