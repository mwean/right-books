class FakeAmazon
  attr_writer :associate_tag

  class << self
    attr_reader :search_results
  end

  def self.stub_search_results(books)
    @search_results = books
  end

  def initialize(*)
  end

  def item_search(*)
    {
      'ItemSearchResponse' => {
        'Items' => {
          'Item' => self.class.search_results.map(&method(:build_book_data))
        }
      }
    }
  end

  def build_book_data(book)
    {
      'DetailPageURL' => book.amazon_link,
      'ImageSets' => {
        'ImageSet' => {
          'SmallImage' => {
            'URL' => 'http://ecx.images-amazon.com/images/I/41VcWETFLRL._SL75_.jpg'
          },
          'LargeImage' => {
            'URL' => book.cover_image_url
          }
        }
      },
      'ItemAttributes' => {
        'Author' => book.authors,
        'ISBN' => book.isbn,
        'PublicationDate' => book.publish_date.to_s,
        'Publisher' => book.publisher,
        'Title' => [book.title, book.subtitle].compact.join(': ')
      },
      'EditorialReviews' => {
        'EditorialReview' => {
          'Content' => book.description
        }
      }
    }
  end
end
