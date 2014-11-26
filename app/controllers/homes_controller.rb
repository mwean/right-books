class HomesController < ApplicationController
  def index
    @new_releases = Book.new_releases(6)
  end

  protected

  def categories
    Category.all.reject { |category| category.name == 'Culture' }
  end

  helper_method :categories
end
