class BoxController < ApplicationController
	def input
	end	

	def output
		
		@name = params[:name]
		@previous = "prince"

	end
	def naverparse
		uri = URI("http://naver.com")
		html_doc = Nokogiri::HTML(open("http://naver.com"))
		@result = html_doc.css("div.tsq_eco_wrap div.tsq_stock ul li h5").inner_text
		
	end
end

