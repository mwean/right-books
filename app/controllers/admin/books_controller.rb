module Admin
  class BooksController < AdminController
    before_action :load_book, only: %i(edit update)

    def index
      @books = Book.order(created_at: :desc)
    end

    def new
      amazon_result = AmazonResult.load(params[:isbn])
      @book = Book.from_amazon_result(amazon_result)
      update_gon
    end

    def create
      amazon_result = AmazonResult.load(params[:isbn])
      book = Book.from_amazon_result(amazon_result)
      book.attributes = book_params
      book.save!

      redirect_to admin_books_path
    end

    def edit
      update_gon
    end

    def update
      @book.update_attributes(book_params)

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

    def load_book
      @book = Book.find_by(slug: params[:id])
    end

    def update_gon
      gon.push(
        categories: categories,
        editor_notes: @book.editor_notes,
        description: @book.description
      )
    end

    def categories
      Category.all.map do |category|
        serialized_category = CategorySerializer.new(
          category,
          root: false,
          selected_category_ids: @book.category_ids
        )

        serialized_category.as_json
      end
    end

    def book_params
      params.require(:book)
        .permit(:title, :subtitle, :authors_list, :category_ids, :editor_notes, :description)
    end

    def store_results(results)
      Redis.current.multi { results.map(&:save) }
    end
  end
end
