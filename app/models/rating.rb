class Rating < ActiveRecord::Base
  attr_accessible :value
  
  belongs_to :mentor
  belongs_to :mentee

  def good?
    value == 'good'
  end

  def bad?
    value == 'bad'
  end
end
