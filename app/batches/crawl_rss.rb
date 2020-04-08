class CrawlRss < ApplicationBatch
  def create_post(title, description, publish_date, image, source_id, url, category_id)
    Post.create(  
      title: title,
      description: description,
      publish_date: publish_date,
      image: image,
      source_id: source_id,
      url: url,
      status: 1,
      category_id: category_id
    ) if (time_diff(Time.now, publish_date) / 3600 <= 1) && description.present? && title.present?
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