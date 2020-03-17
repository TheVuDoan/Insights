namespace :crawl_news_rss do
  task run: :environment do |_task, _args|
    require 'rss'
    require 'open-uri'
    
    begin
      url1 = 'https://vnexpress.net/rss/tin-moi-nhat.rss'
      open(url1) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          create_post(
            item.title,
            item.description[/(?<=\<\/br\>).*/],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" \>/m, 1],
            1,
            item.link
          )
        end
      end
    rescue => e
    end

    begin
      url2 = 'https://tuoitre.vn/rss/tin-moi-nhat.rss'
      open(url2) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          create_post(
            item.title,
            item.description[/(?<=\<\/a\>).*/],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" \/\>/m, 1],
            2,
            item.link
          )
        end
      end
    rescue => e
      url2 = 'https://tuoitre.vn/rss/thoi-su.rss'
      open(url2) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          create_post(
            item.title,
            item.description[/(?<=\<\/a\>).*/],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" \/\>/m, 1],
            2,
            item.link
          )
        end
      end
    end

    begin
      url3 = 'https://vietnamnet.vn/rss/tin-moi-nong.rss'
      open(url3) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          create_post(
            item.title,
            item.description,
            item.pubDate.utc,
            nil,
            3,
            item.link
          )
        end
      end
    rescue => e
    end
    
    begin 
      url4 = 'https://kenh14.vn/home.rss'
      open(url4) do |rss|
        feed = RSS::Parser.parse(rss, false)
        feed.items.each do |item|
          create_post(
            item.title,
            item.description[/\<span\>(.*?)\<\/span\>/m, 1],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" width/m, 1],
            4,
            item.link
          )
        end
      end
    rescue => e
    end
  end

  def create_post(title, description, publish_date, image, source_id, url)
    Post.create(  
      title: title,
      description: description,
      publish_date: publish_date,
      image: image,
      source_id: source_id,
      url: url
    ) if (time_diff(Time.now, publish_date) / 3600 <= 2) && description.present? && title.present?
  end

  def time_diff(time_a, time_b)
    difference = time_a - time_b
  
    if difference > 0
      difference
    else
      24 * 3600 + difference 
    end
  end
end
