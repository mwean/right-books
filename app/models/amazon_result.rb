class AmazonResult
  include ActiveModel::SerializerSupport

  attr_accessor :title, :subtitle, :authors, :small_cover_image_url
  attr_accessor :cover_image_url, :publish_date, :publisher, :description
  attr_accessor :amazon_link, :isbn

  def self.new(data = nil)
    super
  rescue
    Rails.logger.debug data.inspect
    return nil
  end

  def initialize(data = nil)
    return unless data
    @data = data

    set_titles
    set_images
    set_description
    set_authors
    set_isbn

    self.publish_date = item_attributes['PublicationDate']
    self.publisher    = item_attributes['Publisher']
    self.amazon_link  = @data.fetch('DetailPageURL')
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
    title_parts = item_attributes.fetch('Title').split(': ')

    self.title    = title_parts[0]
    self.subtitle = title_parts[1]
  end

  def set_images
    image_sets = [@data.fetch('ImageSets').fetch('ImageSet')].flatten

    self.small_cover_image_url = image_sets.first.fetch('SmallImage').fetch('URL')
    self.cover_image_url       = image_sets.first.fetch('LargeImage').fetch('URL')
  end

  def set_description
    reviews = @data.fetch('EditorialReviews').fetch('EditorialReview')
    self.description = [reviews].flatten.first.fetch('Content')
  end

  def set_authors
    if item_attributes['Author']
      self.authors = [item_attributes.fetch('Author')].flatten
    else
      creators = [item_attributes.fetch('Creator')].flatten
      creator_names = creators.map { |creator| creator.fetch('__content__') }
      self.authors = creator_names.uniq
    end
  end

  def set_isbn
    self.isbn = item_attributes['ISBN'] || item_attributes.fetch('EISBN')
  end

  def item_attributes
    @data.fetch('ItemAttributes')
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
