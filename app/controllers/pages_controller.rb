class PagesController < ApplicationController
  def fnba
    require 'open-uri'
    require 'nokogiri'
    @items = Array.new
    document = Nokogiri::HTML.parse(open('https://www.fnbalaska.com/about-us/about-first-national/press-releases'))
    document.css("div#PressBoss tr").each_with_index do |row,index|
      unless index == 0
        @items << Item.new(row.children[1].text,
                        row.children[3].children.first[:href],
                        row.children[3].content.gsub(/&/,''),
                        row.children[1].text)
      end
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end
end