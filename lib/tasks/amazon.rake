namespace :amazon do
  desc 'Update Amazon links for all books using current credentials'
  task update_links: :environment do
    client = Vacuum.new('US').tap do |request|
      request.associate_tag = ENV['AMAZON_ASSOCIATE_TAG']
    end

    Book.limit(2).find_each do |book|
      Rails.logger.info "Updating #{book.title}..."

      begin
        data = client.item_lookup(query: { 'ItemId' => book.isbn }).to_h
        new_link = data['ItemLookupResponse']['Items']['Item'].fetch('DetailPageURL')
        book.update_attributes(amazon_link: new_link)
      rescue => e
        Rails.logger.warn e.inspect
        Rails.logger.warn book.id
      end

      sleep 1 # API rate limit is 1 request/second
    end
  end
end
