namespace :crawl_news_rss do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'
    
    begin
      url1 = 'https://vnexpress.net/rss/tin-moi-nhat.rss'
      open(url1) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          Post.create(
            title: item.title,
            description: item.description[/(?<=\<\/br\>).*/],
            publish_date: item.pubDate.utc,
            image: item.description[/src\=\"(.*?)\" \>/m, 1],
            source_id: 1,
            url: item.link
          ) if !Post.exists?(title: item.title) && item.description.present?
        end
      end
    rescue => e
    end

    begin
      url2 = 'https://tuoitre.vn/rss/tin-moi-nhat.rss'
      open(url2) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          Post.create(  
            title: item.title,
            description: item.description[/(?<=\<\/a\>).*/],
            publish_date: item.pubDate.utc,
            image: item.description[/src\=\"(.*?)\" \/\>/m, 1],
            source_id: 2,
            url: item.link
          ) if !Post.exists?(title: item.title) && item.description.present?
        end
      end
    rescue => e
      url2 = 'https://tuoitre.vn/rss/thoi-su.rss'
      open(url2) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          Post.create(  
            title: item.title,
            description: item.description[/(?<=\<\/a\>).*/],
            publish_date: item.pubDate.utc,
            image: item.description[/src\=\"(.*?)\" \/\>/m, 1],
            source_id: 2,
            url: item.link
          ) if !Post.exists?(title: item.title) && item.description.present?
        end
      end
    end

    begin
      url3 = 'https://vietnamnet.vn/rss/tin-moi-nong.rss'
      open(url3) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          Post.create(
            title: item.title,
            description: item.description,
            publish_date: item.pubDate.utc,
            image: nil,
            source_id: 3,
            url: item.link
          ) if !Post.exists?(title: item.title) && item.description.present?
        end
      end
    rescue => e
    end
    
    begin 
      url4 = 'https://kenh14.vn/home.rss'
      open(url4) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          Post.create(  
            title: item.title,
            description: item.description[/(?<=\<\/a\>).*/],
            publish_date: item.pubDate.utc,
            image: item.description[/src\=\"(.*?)\" width/m, 1],
            source_id: 4,
            url: item.link
          ) if !Post.exists?(title: item.title) && item.description.present?
        end
      end
    rescue => e
    end
  end
end
