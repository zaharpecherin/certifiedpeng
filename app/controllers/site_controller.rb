class SiteController < ApplicationController
  before_action :authenticate_user!, only: :dashboard
  before_action :check_subscribtion, only: :dashboard

  def index
    @categories = Category.all.order('created_at ASC')
  end

  def dashboard
    @top_likes = Like.get_statistic.limit(30)
    @top_three_likes = @top_likes.first(3)
    @user_tags = current_user.tags.pluck(:tag_name).join(', ')

    @not_added_tags = Tag::TAGS_COUNT - current_user.tags.count

    @user_tags_statistic = current_user.get_user_statistic if current_user.tags.any?
    @result = Like.search_request(params[:search])
  end

  def send_email
    recipient_emails = ['online@gorillatheory.com', 'admin@certifiedpeng.com', 'henrychuks@hotmail.com']

    if params['g-recaptcha-response'].present?
      recipient_emails.each do |recipient|
        NotificationMailer.contact_us_notification(params[:options], recipient).deliver
      end
      flash[:notice] = 'Thank you for your feedback'
    else
      flash[:error] = 'Do not ignore reCAPTCHA checkbox'
    end
    redirect_to contact_us_path
  end

  def category
    @category = Category.find_by_name(params[:name])
  end

  def merchandise; end

  def contact_us; end

  def terms; end

  def about_us; end

  private

    def check_subscribtion
      redirect_to new_subscriber_path if current_user && !current_user.admin? && !current_user.subscriber?
    end
end
