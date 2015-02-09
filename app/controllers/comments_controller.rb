class CommentsController < ApplicationController
  def create
    if current_user
      comment = create_comment

      render json: CommentSerializer.new(comment, root: false)
    else
      head :unauthorized
    end
  end

  def destroy
    if current_user && current_user.admin?
      Comment.find(params[:id]).destroy

      head :ok
    else
      head :unauthorized
    end
  end

  private

  def create_comment
    book = Book.find_by(slug: params[:book_id])

    book.comments.create(
      body: params[:body],
      user: current_user,
      parent_id: params[:parent_id]
    )
  end
end
