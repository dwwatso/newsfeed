class Rss
  attr_accessor :channel
  def initialize(title, link, description)
    @channel = Channel.new(title, link, description)
  end
  #def to_xml()
    
  #end
end