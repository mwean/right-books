class CategoriesController < ApplicationController
  helper_method :categories

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
    @categories ||= Category.all + [NewReleasesCategory.new]
  end
end
