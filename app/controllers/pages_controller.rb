class PagesController < ApplicationController
  def main
    require 'open-uri'
    require 'nokogiri'
    @xml = '<?xml version="1.0" encoding="UTF-8" ?><rss version="2.0">' +
    '<channel><title>FNBA Headlines</title>' +
    '<link>http://localhost:3000/</link><description>First National Bank News and Updates</description>'
    document = Nokogiri::HTML.parse(open('https://www.fnbalaska.com'))
    document.css("div.content-well.current-headlines li").each do |list|
      @xml += "<item><title>#{list.content}</title><link>#{list[:href]}</link><description>Read More.</description></item>"
    end
    @xml += '</channel></rss>'
  end
end