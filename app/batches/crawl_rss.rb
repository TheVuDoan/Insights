class CrawlRss < ApplicationBatch
  def create_post(title, description, publish_date, image, source_id, url, category_id)
    if publish_date > 1.hour.ago && description.present? && title.present?
      Post.create(  
        title: title,
        description: description,
        publish_date: publish_date,
        image: image,
        source_id: source_id,
        url: url,
        status: 1,
        category_id: category_id
      )
    end
  end
end