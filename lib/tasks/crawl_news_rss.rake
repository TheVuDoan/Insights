namespace :crawl_news_rss do
  task run: :environment do |_task, _args|
    CrawlWorldNewsRss.execute
    CrawlGeneralNewsRss.execute
    CrawlSportNewsRss.execute
    CrawlEducationNewsRss.execute
    CrawlTravelNewsRss.execute
    CrawlEconomyNewsRss.execute
  end
end
