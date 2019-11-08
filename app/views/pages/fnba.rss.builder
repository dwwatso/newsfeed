xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "FNBA News"
		xml.description "First National Bank Alaska News and Updates"
		xml.link "https://rss-fnba-feed.herokuapp.com/pages.rss"
		@items.each do |article|
			xml.item do
				xml.title article.title
				xml.description article.description
				xml.pubDate article.pubDate.to_s
				xml.link article.link
				xml.guid article.link
			end
		end
	end
end