require 'rails_helper'

describe Book do
  describe '.new_releases' do
    it 'returns the n most recent books' do
      publish_dates = (1..3).map { |n| n.days.ago }.shuffle
      publish_dates.map { |date| create(:book, publish_date: date) }
      oldest_date = publish_dates.min

      new_releases = Book.new_releases(2)
      expect(new_releases.size).to eq(2)
      expect(new_releases.map(&:publish_date)).not_to include(oldest_date)
    end
  end

  describe '.with_category_id' do
    it 'returns all books with that category id' do
      book1 = create(:book, category_ids: [1, 2])
      create(:book, category_ids: [3])

      expect(Book.with_category_id(1)).to eq([book1])
      expect(Book.with_category_id(2)).to eq([book1])
    end
  end
end
