class NewReleasesCategory
  def name
    'New Releases'
  end

  def key
    'new_releases'
  end

  def slug
    'new-releases'
  end

  alias_method :to_param, :slug

  def description
    nil
  end

  def image_url
    nil
  end

  def ==(other)
    other.instance_of?(self.class)
  end
end
