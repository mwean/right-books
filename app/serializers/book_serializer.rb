class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :cover_image_url, :edit_path, :authors_sentence

  def edit_path
    Rails.application.routes.url_helpers.edit_admin_book_path(object)
  end
end
