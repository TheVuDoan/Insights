namespace :crawl_news_rss do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'
  
    url = 'https://vnexpress.net/rss/tin-moi-nhat.rss'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        Post.create(
          title: item.title,
          description: item.description[/(?<=\<\/br\>).*/],
          publish_date: item.pubDate,
          image: item.description[/src\=\"(.*?)\" \>/m, 1],
          source: 'VnExpress',
          url: item.link
        ) if !Post.exists?(title: item.title)
      end
    end
  end
end
