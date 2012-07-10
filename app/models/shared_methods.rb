module SharedMethods
  def add_tag(value)
    if tag = Tag.find_by_value(value)
      self.tags.push(tag)
    else
      self.tags.create(value: value.downcase)
    end
  end
  
  def add_tags(tags)
    tags.each {|value| self.add_tag(value) }
  end
  
  def m(other)
    num = (self.tags & other.tags).length
    binding.pry
    100 - (50/( num * (1 + other.id % 5) ))
  end
end