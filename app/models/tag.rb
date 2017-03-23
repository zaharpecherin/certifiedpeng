class Tag < ActiveRecord::Base
  belongs_to :user

  def self.exist?(tags)
    tags.each do |tag|
      tag = Tag.find_by_tag_name(tag)
      if tag
        return true
      end
    end
    false
  end
end