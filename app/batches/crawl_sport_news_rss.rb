class CrawlSportNewsRss < CrawlRss
  CATEGORY_ID = 3

  private

  def process
    require 'rss'
    require 'open-uri'
    
    urls = [
      'https://vnexpress.net/rss/the-thao.rss',
      'https://tuoitre.vn/rss/the-thao.rss',
      'https://kenh14.vn/sport.rss',
      'https://cdn.24h.com.vn/upload/rss/thethao.rss',
      'https://vtv.vn/the-thao.rss',
      'https://www.doisongphapluat.com/rss/the-thao.rss',
      'https://baogiaothong.vn/the-thao.rss'
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
      feed = RSS::Parser.parse(rss, ignore_unknown_element=false)
      feed.items.each do |item|
        if item.pubDate
          pubDate = Rails.env == "production" ? item.pubDate.utc - 7.hours : item.pubDate
          create_post(
            item.title,
            item.description[/(?<=\<\/a\>).*/],
            pubDate,
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
            item.description[/\<span\>(.*?)\<\/span\>/m, 1],
            item.pubDate.utc - 7.hours,
            item.description[/src\=\"(.*?)\" width/m, 1],
            4,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end

    open(urls[3]) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.pubDate
          create_post(
            item.title,
            item.description[/(?<=\<br \/\>).*/],
            item.pubDate.utc,
            item.description[/src\=\'(.*?)\' alt/m, 1],
            5,
            item.link,
            CATEGORY_ID
          )
        end
      end
    end

    open(urls[4]) do |rss|
      feed = RSS::Parser.parse(rss, ignore_unknown_element=false)
      feed.items.each do |item|
        if item.pubDate
          pubDate = Rails.env == "production" ? item.pubDate.utc - 7.hours : item.pubDate
          create_post(
            item.title,
            item.description[/(?<=\<\/a\>).*/],
            pubDate,
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