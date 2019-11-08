class Channel
  def initialize(title, link, description)
    @title = title
    @link = link
    @description = description
    @items = []    
  end
  def append(item)
    @items << item
    self
  end
end