namespace :crawl_news_data do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'

    begin
      url3 = 'https://vietnamnet.vn/rss/tin-moi-nong.rss'
      open(url3) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          puts
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
    end
  end
end
