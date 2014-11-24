class HomesController < ApplicationController
  def index
    @new_releases = Book.new_releases
  end
end
