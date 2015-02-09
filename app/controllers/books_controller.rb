class BooksController < ApplicationController
  before_action :load_book, except: :new_releases

  def show
    comments = CommentsSerializer.new(@book.comments.includes(:user).arrange(order: :created_at))

    gon.push(
      comments: comments.as_json,
      new_comment_url: book_comments_path(@book),
      comments_url: comment_path(1).sub(/\/1$/, '')
    )
  end

  def new_releases
    @books = Book.new_releases
  end

  private

  def load_book
    @book = Book.find_by(slug: params[:id])
  end
end
