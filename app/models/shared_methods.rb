module SharedMethods
  def add_tag(value)
    if tag = Tag.find_by_value(value)
      self.tags.push(tag)
    else
      self.tags.create(value: value)
    end
  end
  
  def add_tags(tags)
    tags.each {|value| self.add_tag(value) }
  end
  
  def match(other)
  end
end