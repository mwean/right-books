class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(slug: params[:id])
    @books = @category.ordered_books
  end
end
