class HomesController < ApplicationController
  def index
    @new_releases = Book.new_releases(6)
  end

  protected

  def categories
    names = [
      'History',
      'Biography & Memoir',
      'Political Philosophy',
      'Economics',
      'Culture'
    ]
    Category.where(name: names)
  end

  helper_method :categories
end
