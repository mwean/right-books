class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :selected

  def initialize(object, options = {})
    @selected_category_ids = (options.delete(:selected_category_ids) || [])
    super
  end

  def selected
    @selected_category_ids.include?(object.id)
  end
end
