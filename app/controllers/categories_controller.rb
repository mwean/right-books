class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(slug: params[:id])
    @books = @category.books
  end
end
