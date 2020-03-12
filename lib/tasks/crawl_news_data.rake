namespace :crawl_news_data do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'

    url2 = 'https://kenh14.vn/home.rss'
    open(url2) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        puts item.pubDate.utc
        # Post.create(  
        #   title: item.title,
        #   description: item.description[/(?<=\<\/a\>).*/],
        #   publish_date: item.pubDate,
        #   image: item.description[/src\=\"(.*?)\" \/\>/m, 1],
        #   source_id: 2,
        #   url: item.link
        # ) if !Post.exists?(title: item.title) && item.description.present?
      end
    end
  end
end
