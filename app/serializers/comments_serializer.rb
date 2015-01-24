class CommentsSerializer
  def initialize(comments_hash)
    @serialized_comments = serialize_children(comments_hash)
  end

  def as_json
    @serialized_comments
  end

  private

  def serialize_children(comments_hash)
    return [] if comments_hash.none?

    comments_hash.map do |comment, children|
      serialized_children = serialize_children(children)
      CommentSerializer.new(comment, root: false, children: serialized_children).as_json
    end
  end
end
