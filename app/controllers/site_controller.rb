class SiteController < ApplicationController
  layout false, only: [:product_name, :page_like_count, :like]
  # protect_from_forgery except: :product_name


  def index
    @categories = Category.all
  end

  def dashboard
    if user_signed_in?
      if !current_user.products.empty?
        @user_tags_statistic = []
        current_user.products.each do |product|
          likes = Like.where(product_name: product.product_name)
          urls =  likes.select(:url).group(:url).pluck(:url)
          urls.each do |u|
            like_count = Like.where(product_name: product.product_name, url: u).count
            hash = {'product_names' => product.product_name, 'url' => u, 'count' => like_count }
            @user_tags_statistic.push(hash)
          end
        end
      end

      @top_likes = Like.select('count(*) AS like_count, url, product_name').group(:url, :product_name).order('like_count DESC').limit(10)

      query = params[:search] if params[:search]

      if query
        search = Like.where(product_name: query)
        if search.present?
          urls =  search.select(:url).group(:url).pluck(:url)
          get_like_statistic(query, urls, 'urls')
        else
          search = Like.where(url: query)
          product_names = search.select(:product_name).group(:product_name).pluck(:product_name)
          get_like_statistic(query, product_names)
        end
      end
    else
      redirect_to user_session_path
    end
  end

  def category
    @category = Category.find_by_name(params[:name])
  end

  def user_tags
    max_tags = 5
    if params[:tags].present?
      tags = params[:tags].split(',')
      if current_user.products.count == max_tags
        flash[:error] = "You can't add more tags"
        redirect_to user_tags_path
      elsif (tags.count + current_user.products.count) > max_tags
        flash[:error] = "You entered too many tags"
        redirect_to user_tags_path
      else
        tags.each do |tag|
          Product.create(product_name: tag, user_id: current_user.id)
          redirect_to user_tags_path
        end
      end
    end
    @not_added_tags = max_tags - current_user.products.count
    @tags = current_user.products
  end

  def contact_us
  end

  def sent_email
    # email = ['online@gorillatheory.com', 'henrychuks@hotmail.com']
    recipient_emails = ['astahovdanil@inbox.ru', 'dynindanya@mail.ru']
    if params["g-recaptcha-response"].present?
      name = params[:name]
      email = params[:email]
      telephone = params[:telephone] if params[:telephone]
      reason = params[:reason]
      recipient_emails.each do |recipient|
        NotificationMailer.contact_us_notification(name, email, telephone, reason, recipient).deliver
      end

      flash[:notice] = "Thank you for your feedback"
      redirect_to contact_us_path
    else
      flash[:error] = "Do not ignore reCAPTCHA checkbox"
      redirect_to contact_us_path
    end

  end

  def get_like_statistic(query, param, type=nil)
    @result = []
    param.each do |p|
      if type == 'urls'
        count = Like.where(product_name: query, url: p).count
        hash = {'product_names' => query, 'url' => p, 'count' => count }
        @result.push(hash)
      else
        count = Like.where(product_name: p, url: query, ).count
        hash = {'product_names' => p, 'url' => query, 'count' => count }
        @result.push(hash)
      end
    end
  end

  def product_name
    headers["Content-Type"] = "text/javascript; charset=utf8"
    headers['Access-Control-Allow-Origin'] = '*'

    @product_name = params[:product_name]
  end

# #create like
  def like
    headers["Content-Type"] = "text/javascript; charset=utf8"
    headers['Access-Control-Allow-Origin'] = '*'

    puts params.inspect
    likes = Like.where(url: params[:url], product_name: params[:product_name])
    like_page_by_ip_rel = likes.where(ip: request.ip)

    like_page_by_ip = like_page_by_ip_rel.first
    like_page_by_ip_rel.first_or_create

    ua = request.user_agent
    mobile = 0

    if ['Android', 'iPhone'].find {|s| ua.include?(s) }
      mobile = 1
    end

    render json: { like_count: likes.count, liked: (like_page_by_ip ? 1 : 0), mobile: mobile}

  end


# #get like count
  def page_like_count
    headers['Access-Control-Allow-Origin'] = '*'
    likes = Like.where(url: params[:url], product_name: params[:product_name])
    like_page_by_ip = likes.where(ip: request.ip).first

    render json:{ like_count: likes.count, liked: (like_page_by_ip ? 1 : 0) }
  end
end
