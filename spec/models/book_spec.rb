require 'rails_helper'

describe Book do
  describe '.new_releases' do
    it 'returns the 6 most recent books' do
      publish_dates = (1..7).map { |n| n.days.ago }.shuffle
      publish_dates.map { |date| create(:book, publish_date: date) }
      oldest_date = publish_dates.min

      new_releases = Book.new_releases
      expect(new_releases.size).to eq(6)
      expect(new_releases.map(&:publish_date)).not_to include(oldest_date)
    end
  end
end
