class Tag < ActiveRecord::Base
  belongs_to :user

  MAX_TAGS_COUNT = 15
  TAGS_COUNT = 5
end
