namespace :crawl_news_data do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'

    url1 = 'https://vietnamnet.vn/rss/tin-moi-nong.rss'
    open(url1) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        Post.create(
          title: item.title,
          description: item.description,
          publish_date: item.pubDate,
          image: nil,
          source: 'Vietnamnet',
          url: item.link
        ) if !Post.exists?(title: item.title) && item.description.present?
      end
    end
  end
end
