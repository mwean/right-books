class AmazonResultSerializer < ActiveModel::Serializer
  attributes :isbn, :full_title, :authors_sentence, :cover_image_url

  def full_title
    [object.title, object.subtitle].compact.join(': ')
  end

  def cover_image_url
    object.small_cover_image_url
  end

  def authors_sentence
    object.authors.to_sentence
  end
end
