class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tags
  has_one :subscriber

  def admin?
    id == 1
  end

  def subscriber?
    self.subscriber && self.subscriber.stripe_id && (self.subscriber.end_date > Time.now)
  end

  def get_purchases
    Purchase.where(email: self.email)
  end

  def get_user_statistic
    tags =  self.tags.select(:tag_name).to_sql
    Like.where("tag_name IN (#{tags})").get_statistic
  end

  def limits_of_tags?
    if exist_purchase?
      self.tags.count == Tag::MAX_TAGS_COUNT
    else
      self.tags.count == Tag::TAGS_COUNT
    end
  end

  def exist_purchase?
    Purchase.find_by_email(self.email).present?
  end
end
