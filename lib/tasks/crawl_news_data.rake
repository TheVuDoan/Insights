namespace :crawl_news_data do
  task run: :environment do |_task, _args|
    agent = Mechanize.new
    page = agent.get "https://vnexpress.net/"
    
    @post_array = []
    puts(page)
    #Mỗi 1 post được bao bởi thẻ div esc-body
  	list_post = page.search "article.list_news"
  
    #Với mỗi post lấy được, tìm kiếm nội dung bên trong
    list_post.each_with_index do |post, num|
    	#Lấy nội dụng title
    	title = post.search("h4.title_news a").text

        #Lấy description
        description = post.search("p.description a").text

        #Tạo hash và đưa vào mảng
        @post_array[num] ={title: title, description: description}
    end
    
    puts(@post_array)
  end
end
