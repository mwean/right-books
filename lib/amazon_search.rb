class AmazonSearch
  def initialize(query)
    @query = query
  end

  def title
    title_parts[0]
  end

  def subtitle
    title_parts[1]
  end

  def author
    item['ItemAttributes']['Author']
  end

  def cover_image
    image_sets.first['LargeImage']['URL']
  end

  def publish_date
    item['ItemAttributes']['PublicationDate']
  end

  def publisher
    item['ItemAttributes']['Publisher']
  end

  def description
    item['EditorialReviews']['EditorialReview']['Content']
  end

  def amazon_link
    item['DetailPageURL']
  end

  def isbn
    item['ItemAttributes']['ISBN']
  end

  private

  def items
    result['ItemSearchResponse']['Items']['Item']
  end

  def title_parts
    full_title = item['ItemAttributes']['Title']
    full_title.split(': ')
  end

  def item
    items.first
  end

  def image_sets
    [item['ImageSets']['ImageSet']].flatten
  end

  def result
    @result ||= request.item_search(query: params).to_h
  end

  def request
    Vacuum.new('US').tap do |request|
      request.associate_tag = ENV['AMAZON_ASSOCIATE_TAG']
    end
  end

  def params
    {
      'SearchIndex'                     => 'Books',
      'Keywords'                        => @query,
      'Operation'                       => 'ItemSearch',
      'ItemSearch.Shared.ResponseGroup' => 'ItemAttributes,Images,EditorialReview'
    }
  end
end
