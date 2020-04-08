namespace :crawl_news_data do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'

    begin
      url3 = 'https://www.doisongphapluat.com/rss/tin-the-gioi.rss'
      open(url3) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          puts item.description
          # create_post(
          #   item.title,
          #   item.description,
          #   item.pubDate.utc,
          #   nil,
          #   3,
          #   item.link
          # )
        end
      end
    rescue => e
      puts e
    end
  end
end
