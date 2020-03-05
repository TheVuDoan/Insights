namespace :crawl_news_rss do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'
  
    url1 = 'https://vnexpress.net/rss/tin-moi-nhat.rss'
    open(url1) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        Post.create(
          title: item.title,
          description: item.description[/(?<=\<\/br\>).*/],
          publish_date: item.pubDate,
          image: item.description[/src\=\"(.*?)\" \>/m, 1],
          source_id: 1,
          url: item.link
        ) if !Post.exists?(title: item.title) && item.description.present?
      end
    end

    url2 = 'https://tuoitre.vn/rss/tin-moi-nhat.rss'
    open(url2) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        Post.create(  
          title: item.title,
          description: item.description[/(?<=\<\/a\>).*/],
          publish_date: item.pubDate,
          image: item.description[/src\=\"(.*?)\" \/\>/m, 1],
          source_id: 2,
          url: item.link
        ) if !Post.exists?(title: item.title) && item.description.present?
      end
    end

    url3 = 'https://vietnamnet.vn/rss/tin-moi-nong.rss'
    open(url3) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        Post.create(
          title: item.title,
          description: item.description,
          publish_date: item.pubDate,
          image: nil,
          source_id: 3,
          url: item.link
        ) if !Post.exists?(title: item.title) && item.description.present?
      end
    end
  end
end
