class AmazonSearch
  def initialize(query)
    @query = query
  end

  def results
    items.map { |item| AmazonResult.new(item) }.compact
  end

  private

  def items
    [response['ItemSearchResponse']['Items']['Item']].flatten
  end

  def response
    @response ||= request.item_search(query: params).to_h
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
