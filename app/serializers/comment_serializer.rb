class CommentSerializer < ActiveModel::Serializer
  attr_reader :children
  attributes :id, :body, :timestamp, :user_name, :children, :reply

  def initialize(object, options = {})
    @children = options.delete(:children)
    super
  end

  def timestamp
    object.created_at.to_i
  end

  def user_name
    object.user.name
  end

  def reply
    object.parent.present?
  end
end
