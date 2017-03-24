class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tags
  has_one :subscriber

  def admin?
    self.id == 1
  end

  def subscriber?
    self.subscriber && self.subscriber.stripe_id && (self.subscriber.end_date > Time.now)
  end

  def get_purchases
    Purchase.where(email: self.email)
  end

  def get_statistic
    statistic = []
    self.tags.each do |tag|
      likes = Like.where(tag_name: tag.tag_name)
      urls =  likes.select(:url).group(:url).pluck(:url)
      urls.each do |u|
        like_count = Like.where(tag_name: tag.tag_name, url: u).count
        like = Like.where(tag_name: tag.tag_name, url: u).order('created_at ASC').first
        countries = Like.select(:country).where(url: u, tag_name: tag.tag_name).pluck(:country).join(', ')
        hash = {'tag_names': tag.tag_name, 'url': u, 'count': like_count, date: like.created_at.strftime("%d %b %Y"), id: like.id, countries: countries }
        statistic.push(hash)
      end
    end
    statistic
  end

  def limits_of_tags?
    self.tags.count == Tag::MAX_TAGS_COUNT
  end

end