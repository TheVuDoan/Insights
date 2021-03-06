class YoutubeVideo < ApplicationRecord
  belongs_to :youtube_channel

  scope :latest, -> { order(published_at: :desc)}

  scope :recent_highest_score, -> { 
    includes(:youtube_channel).where('published_at > ?', 1.day.ago)
    .sort_by(&:score).reverse.first(6) 
  }

  scope :sort_by_highest_score, -> {
    includes(:youtube_channel).sort_by(&:score).reverse
  }

  def score
    view_count + like_count * 5 - dislike_count * 10
  end
end
