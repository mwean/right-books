class CommentSerializer < ActiveModel::Serializer
  attr_reader :children
  attributes :id, :body, :timestamp, :user, :children, :reply

  def initialize(object, options = {})
    @children = options.delete(:children)
    super
  end

  def timestamp
    object.created_at.to_i
  end

  def reply
    object.parent.present?
  end

  def user
    UserSerializer.new(object.user, root: false)
  end
end
