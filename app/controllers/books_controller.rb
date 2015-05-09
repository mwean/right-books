class BooksController < ApplicationController
  def show
    @book = Book.find_by(slug: params[:id])
    comments = CommentsSerializer.new(@book.comments.includes(:user).arrange(order: :created_at))

    gon.push(
      comments: comments.as_json,
      new_comment_url: book_comments_path(@book),
      comments_url: comment_path(1).sub(%r{/1$}, '')
    )
  end
end
