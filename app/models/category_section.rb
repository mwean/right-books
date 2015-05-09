CategorySection = Struct.new(:category) do
  delegate :name, to: :category

  def to_partial_path
    'category_section'
  end

  def books
    category.books.limit(6)
  end
end
