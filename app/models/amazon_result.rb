class AmazonResult
  include ActiveModel::SerializerSupport

  attr_accessor :title, :subtitle, :authors, :small_cover_image_url
  attr_accessor :cover_image_url, :publish_date, :publisher, :description
  attr_accessor :amazon_link, :isbn

  def initialize(data = nil)
    return unless data
    @data = data

    set_titles
    set_images
    set_description
    set_authors
    set_isbn

    self.publish_date = @data['ItemAttributes']['PublicationDate']
    self.publisher    = @data['ItemAttributes']['Publisher']
    self.amazon_link  = @data['DetailPageURL']
  end

  def save
    Redis.current.setex("amazon_result:#{isbn}", 48.hours, Oj.dump(attribute_values.to_h))
  end

  def self.load(isbn)
    data = Oj.load(Redis.current.get("amazon_result:#{isbn}"))
    new.load(data)
  end

  def load(data)
    attributes.each { |attr| send("#{attr}=", data[attr]) }

    self
  end

  private

  def set_titles
    title_parts = @data['ItemAttributes']['Title'].split(': ')

    self.title    = title_parts[0]
    self.subtitle = title_parts[1]
  end

  def set_images
    image_sets = [@data['ImageSets']['ImageSet']].flatten

    self.small_cover_image_url = image_sets.first['SmallImage']['URL']
    self.cover_image_url       = image_sets.first['LargeImage']['URL']
  end

  def set_description
    self.description = [@data['EditorialReviews']['EditorialReview']].flatten.first['Content']
  end

  def set_authors
    if @data['ItemAttributes']['Author']
      self.authors = [@data['ItemAttributes']['Author']].flatten
    else
      creators = @data['ItemAttributes']['Creator'].map { |creator| creator['__content__'] }
      self.authors = creators.uniq
    end
  end

  def set_isbn
    self.isbn = @data['ItemAttributes']['ISBN'] || @data['ItemAttributes']['EISBN']
  end

  def attribute_values
    values = attributes.map { |attr| send(attr) }
    attributes.zip(values)
  end

  def attributes
    %i(
      title subtitle authors small_cover_image_url cover_image_url publish_date
      publisher description amazon_link isbn
    )
  end
end
