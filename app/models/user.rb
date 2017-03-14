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

  def is_subscriber?
    self.subscriber && self.subscriber.stripe_id && (self.subscriber.end_date > Time.now)
  end
end