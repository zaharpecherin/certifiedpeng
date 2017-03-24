class Tag < ActiveRecord::Base
  belongs_to :user
  # before_save :validate_tag

  MAX_TAGS_COUNT = 5

  def self.exist?(tags)
    tags.each do |tag|
      tag = Tag.find_by_tag_name(tag)
      if tag
        return true
      end
    end
    false
  end

  def self.unique?(tag)
    Tag.find_by_tag_name(tag).blank?
  end
end