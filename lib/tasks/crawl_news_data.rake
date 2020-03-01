namespace :crawl_news_data do
  task run: :environment do |_task, _args|
    agent = Mechanize.new
    page = agent.get "https://vnexpress.net/"
    MAX_ARTICLE_CRAWL = 18
    
    @post_array = []
  	list_post = page.search "article.list_news"
  
    list_post.each_with_index do |post, num|
      break if num == MAX_ARTICLE_CRAWL
    	title = post.search("h4.title_news a").text
      description = post.search("p.description a").text
      publish_date = Date.today.to_s
      source = "vnexpress"
      url = post.at("h4.title_news a").attributes["href"].text

      Post.create(
        title: title,
        description: description,
        publish_date: publish_date,
        source: source,
        url: url
      ) if !Post.exists?(title: title)
    end
  end
end
