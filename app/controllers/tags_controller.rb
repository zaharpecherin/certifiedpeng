class TagsController < ApplicationController
  skip_before_filter :check_subscribtion

  def index
    max_tags = 5
    if params[:tag].present?
      tag = params[:tag]
      if (tag.include? " ") || (tag.include? ",")
        flash[:error] = "Tag must not contain spaces or commas"
      else
        existing_tag = Tag.find_by_tag_name(tag)
        if existing_tag.present?
          flash[:error] = "Tag must be unique"
        else
          if current_user.tags.count == max_tags
            flash[:error] = "You can't add more then 5 tags"
          else
            Tag.create(tag_name: tag, user_id: current_user.id)
          end
        end
      end
      redirect_to tags_path
    end
    @not_added_tags = max_tags - current_user.tags.count
    @tags = current_user.tags
  end

  def show
    @tag = Tag.find_by_id(params[:id])
  end

  def tag_detailing
    @like = Like.find_by_id(params[:id])
    @like_count = Like.where(tag_name: @like.tag_name, url: @like.url).count
    @date = Like.where(tag_name: @like.tag_name, url: @like.url).order('created_at ASC').first
    @countries = Like.select(:country).where(url: @like.url, tag_name: @like.tag_name).pluck(:country).join(', ')
  end

end

