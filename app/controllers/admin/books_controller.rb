module Admin
  class BooksController < AdminController
    def index
      @books = Book.all
    end

    def new
      amazon_result = AmazonResult.load(params[:isbn])
      @book = Book.from_amazon_result(amazon_result)

      categories = ActiveModel::ArraySerializer.new(
        Category.all,
        each_serializer: CategorySerializer
      )

      gon.push(
        categories: categories.as_json,
        editor_notes: @book.editor_notes,
        description: @book.description
      )
    end

    def create
      amazon_result = AmazonResult.load(params[:isbn])
      book = Book.from_amazon_result(amazon_result)
      book.attributes = book_params
      book.save!

      redirect_to admin_books_path
    end

    def search
      results = AmazonSearch.new(params[:q]).results.take(5)
      store_results(results)

      serialized_results = ActiveModel::ArraySerializer.new(
        results,
        each_serializer: AmazonResultSerializer
      )

      render json: serialized_results
    end

    private

    def book_params
      params.require(:book)
        .permit(:title, :subtitle, :authors_list, :category_ids, :editor_notes, :description)
    end

    def store_results(results)
      Redis.current.multi { results.map(&:save) }
    end
  end
end
