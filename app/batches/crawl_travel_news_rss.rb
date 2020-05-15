class CrawlTravelNewsRss < CrawlRss
  CATEGORY_ID = 5

  private

  def process
    require 'rss'
    require 'open-uri'
    
    urls = [
      'https://vnexpress.net/rss/du-lich.rss',
      'https://tuoitre.vn/rss/du-lich.rss',
      'https://cdn.24h.com.vn/upload/rss/dulich24h.rss',
      'https://baogiaothong.vn/di.rss'
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

    open(urls[3]) do |rss|
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