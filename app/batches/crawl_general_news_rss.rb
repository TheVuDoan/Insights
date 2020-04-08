class CrawlGeneralNewsRss < CrawlRss
  CATEGORY_ID = 2

  private

  def process
    require 'rss'
    require 'open-uri'
    
    urls = [
      'https://vnexpress.net/rss/thoi-su.rss',
      'https://tuoitre.vn/rss/thoi-su.rss',
      'https://vietnamnet.vn/rss/thoi-su.rss',
      'https://kenh14.vn/xa-hoi.rss',
      'https://vtv.vn/trong-nuoc.rss',
      'https://www.doisongphapluat.com/rss/tin-trong-nuoc.rss',
      'https://baogiaothong.vn/thoi-su-xa-hoi.rss'
    ]

    open(urls[0]) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description[/(?<=\<\/br\>).*/],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" \>/m, 1],
            1,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end

    open(urls[1]) do |rss|
      feed = RSS::Parser.parse(rss, false)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description[/(?<=\<\/a\>).*/],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" \/\>/m, 1],
            2,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end

    open(urls[2]) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description,
            item.pubDate.utc,
            nil,
            3,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end
    
    open(urls[3]) do |rss|
      feed = RSS::Parser.parse(rss, false)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description[/\<span\>(.*?)\<\/span\>/m, 1],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" width/m, 1],
            4,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end

    open(urls[4]) do |rss|
      feed = RSS::Parser.parse(rss, false)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description[/(?<=\<\/a\>).*/],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" \/\>/m, 1],
            6,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end

    open(urls[5]) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description[/(?<=\<br\/\>).*/],
            item.pubDate.utc,
            item.description[/src\=\"(.*?)\" width/m, 1],
            7,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end

    open(urls[6]) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description,
            item.pubDate.utc,
            nil,
            8,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end
  end
end