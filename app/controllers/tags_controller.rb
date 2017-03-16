class TagsController < ApplicationController

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
  end

end

