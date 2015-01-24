class BooksController < ApplicationController
  before_action :load_book, except: :new_releases

  def show
    comments = CommentsSerializer.new(@book.comments.includes(:user).arrange(order: :created_at))

    gon.push(
      comments: comments.as_json,
      new_comment_url: comment_book_path(@book)
    )
  end

  def comment
    if current_user
      comment = @book.comments.create(
        body: params[:body],
        user: current_user,
        parent_id: params[:parent_id]
      )

      render json: CommentSerializer.new(comment, root: false)
    else
      head :unauthorized
    end
  end

  def new_releases
    @books = Book.new_releases
  end

  private

  def load_book
    @book = Book.find_by(slug: params[:id])
  end
end
