class Like < ActiveRecord::Base

  def self.get_like_statistic(query, param, type=nil)
    @result = []
    param.each do |p|
      url = type == 'urls' ? query : p
      tag_name = type == 'urls' ? p : query
      count = Like.where(tag_name: tag_name, url: url).count
      hash = {'tag_names' => tag_name, 'url' => url, 'count' => count }
      @result.push(hash)
    end
  end

end
