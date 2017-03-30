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
    tags =  self.tags.select(:tag_name).to_sql
    Like.where("tag_name IN (#{tags})").select("COUNT(*) AS like_count, url, tag_name,  MIN(created_at) AS created_at, string_agg(country, ', ') AS countries").group(:url, :tag_name).order('like_count DESC')
  end

  def limits_of_tags?
    self.tags.count == Tag::MAX_TAGS_COUNT
  end

end