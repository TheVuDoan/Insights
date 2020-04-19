class YoutubeVideo < ApplicationRecord
  belongs_to :youtube_channel

  scope :recent_highest_score, -> { 
    includes(:youtube_channel).where('published_at > ?', 12.hours.ago)
    .sort_by(&:score).reverse.first(6) 
  }

  def score
    view_count + like_count * 5 - dislike_count * 10
  end
end
