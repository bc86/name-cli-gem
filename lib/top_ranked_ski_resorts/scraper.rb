class TopRankedSkiResorts::Scraper
	#def initialize(url = nil)
	#	@url = url
	#end

	attr_accessor :resort

	#def scrape_article
	#	@doc = Nokogiri::HTML(open(@url))
	#	@doc.search("table.rank1").text
	#end

	BASE_ZRANKINGS_URL = "https://zrankings.com"

	def primary_page
		doc = Nokogiri::HTML(open(BASE_ZRANKINGS_URL))
		doc.search("tbody tr").map do |tbody_tr|
			hrefs = tbody_tr.search("td a").map { |a|
				a ['href'] if a['href'] =~ /^\/ski-resorts\// }.compact.uniq
				hrefs.each do |href|
					remote_url = BASE_ZRANKINGS_URL + href
					second = Nokogiri::HTML(open(remote_url))
			@resort = TopRankedSkiResorts::Resort.new
		
		#Scraping of the first page

			resort.rank = tbody_tr.search("td:first-of-type").text.to_i
			resort.place = tbody_tr.search("td.name-rank a").text
			resort.state = tbody_tr.search("td.name-rank span").text
			resort.true_snowfall = tbody_tr.search("td.desktop-375").text
			resort.acreage = tbody_tr.search("td.desktop-750").text
			resort.vertical_drop = tbody_tr.search("td.desktop-620").text
			resort.summit_elevation = tbody_tr.search("td.desktop-850").text
			resort.lifts = tbody_tr.search("td.desktop-950").text
			resort.score = tbody_tr.search("td#score").text.to_i

		#secondary page scrape

					resort.total_runs = second.search("div.side-stats-2 ul li:nth-child(2) span").text
   					resort.longest_run = second.search("div.side-stats-2 ul li:nth-child(3) span").text
   					resort.terrain_parks = second.search("div.side-stats-2 ul li:nth-child(6) span").text
   					resort.halfpipes = second.search("div.side-stats-2 ul li:nth-child(8) span").text
   					resort.airport = second.search("div.side-stats-2 ul li:nth-child(10) span").text
   					resort.protip = second.search("div.toptiptext p").text

   					resort.save
			end
		end
	end
end