namespace :scrape_event do
  desc "1年間のイベントデータを抽出"
  task scrape_event: :environment do
    require 'nokogiri'
    require 'httparty'
    require 'open-uri'

    url = 'https://www.kinenbi.gr.jp/'
    html = HTTParty.get(url)
    doc = Nokogiri::HTML(html)

    doc.css('.some-class').each do |element|
      title = element.css('.title').text.strip
      description = element.css('.description').text.strip
      puts "Title: #{title}, Description: #{description}"
    end
  end
end
