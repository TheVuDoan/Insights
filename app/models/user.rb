class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable , omniauth_providers: [:facebook, :google_oauth2]
  
  has_many :bookmarks
  has_many :views
  has_many :likes
  has_many :reports
  has_many :user_view_sources

  before_create :set_default_info

  def view_count
    Like.where(user_id: id).count
  end

  def like_count
    Like.where(user_id: id).count
  end

  def bookmark_count
    Bookmark.where(user_id: id).count
  end

  def no_iteraction?
    view_count + like_count + bookmark_count == 0
  end

  def report_count
    Report.where(user_id: id).count
  end

  class << self
    def from_omniauth(auth)
      result = User.where(email: auth.info.email).first
      if result
        return result
      else
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
          user.fullname = auth.info.name
          user.image = auth.info.image
          user.uid = auth.uid
          user.provider = auth.provider
  
          #  If you are using confirmable and the provider(s) you use validate emails
          user.skip_confirmation!
        end
      end
    end
  end

  private

  def set_default_info
    self.image ||= '/images/default_user.jpg'
    self.provider ||= 'insights'
  end
end
