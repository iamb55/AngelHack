module SharedMethods
  def add_tag(value)
    value = value.downcase
    if tag = Tag.find_by_value(value)
      self.tags.push(tag)
    else
      self.tags.create(value: value)
    end
  end
  
  def add_tags(tags)
    tags.each {|value| self.add_tag(value) } if tags
  end
  
  def m(other)
    num = (self.tags & other.tags).length
    100 - (50/( num * (1 + other.id % 5) ) )
  end
end