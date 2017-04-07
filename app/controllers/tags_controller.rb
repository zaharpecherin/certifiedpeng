class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @not_added_tags = Tag::MAX_TAGS_COUNT - current_user.tags.count
    @tags = current_user.tags
  end

  def create
    error = get_error(params[:tag])
    if error
      flash[:error] = error
    else
      Tag.create(tag_name: params[:tag], user_id: current_user.id)
        if current_user.limits_of_tags?
          flash[:alert] = 'You have reached your limit of Certified Peng tracking tag allowance'
        end
    end
    redirect_to tags_path
  end

  def show
    @tag = Tag.find_by_id(params[:id])
     likes = Like.find_by_tag_name(@tag.tag_name)
    if likes && params[:tag].present?
      flash[:error] = "This tag already has 'likes' and you can not edit this tag"
    elsif !@tag.edited && params[:tag] && !likes
      @tag.update_attributes(tag_name: params[:tag], edited: true)
    elsif @tag.edited && params[:tag]
      flash[:error] = 'You can edit tag only once'
    end
  end

  private

  def get_error(tag)
    if current_user.limits_of_tags?
      'You cant add more then 5 tags'
    elsif tag.include?(' ') || tag.include?(',')
      'Tag must not contain spaces or commas'
    elsif Tag.exists?(tag_name: tag)
      'Tag you entered already exists'
    end
  end
end

