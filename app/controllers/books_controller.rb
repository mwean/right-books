class BooksController < ApplicationController
  def show
    @book = Book.find_by(slug: params[:id])
  end

  def new_releases
    @books = Book.new_releases
  end
end
