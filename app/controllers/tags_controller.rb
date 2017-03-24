class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @not_added_tags = Tag::MAX_TAGS_COUNT - current_user.tags.count
    @tags = current_user.tags
  end

  def create
    tag = params[:tag]
    if current_user.limits_of_tags?
      flash[:error] = 'You cant add more then 5 tags'
    elsif (tag.include? ' ') || (tag.include? ',')
      flash[:error] = 'Tag must not contain spaces or commas'
    elsif !Tag.unique?(tag)
      flash[:error] = 'Tag must be unique'
    else
      Tag.create(tag_name: tag, user_id: current_user.id)
    end
    redirect_to tags_path
  end

  def show
    @tag = Tag.find_by_id(params[:id])
  end
end

