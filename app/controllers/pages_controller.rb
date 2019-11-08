class PagesController < ApplicationController
  def main
    require 'open-uri'
    require 'nokogiri'
    
    #@xml = '<?xml version="1.0" encoding="UTF-8" ?><rss version="2.0">' +
    #        '<channel><title>FNBA Headlines</title>' +
    #        '<link>https://rss-fnba-feed.herokuapp.com/pages.xml</link>' + 
    #        '<description>First National Bank Alaska News and Updates</description>'
    debugger
    @rss = Rss.new("FNBA News","https://rss-fnba-feed.herokuapp.com/pages.xml",
            "First National Bank Alaska News and Updates")
    document = Nokogiri::HTML.parse(open('https://www.fnbalaska.com/about-us/about-first-national/press-releases'))
    document.css("div#PressBoss tr").each_with_index do |row,index|
      unless index == 0
        @item = Item.new(row.children[1].text,
                        row.children[3].children.first[:href],
                        row.children[3].content.gsub(/&/,''),
                        row.children[1].text)
        @rss.channel.append @item
    #    @xml += "<item><title>#{row.children[1].text}</title><link>" + 
    #            "#{row.children[3].children.first[:href]}</link><description>" +
    #            "#{row.children[3].content.gsub(/&/,'')}</description></item>"
      end
    end
    #@xml += '</channel></rss>'
    #proc = Proc.new { |options, record| options[:builder].tag!('version','2.0') }
    respond_to do |format|
      format.html
    #  format.xml { render xml: @xml }
    #debugger
      format.xml { render xml: @rss }
      #.to_xml(procs: [proc])
    end
  end
end