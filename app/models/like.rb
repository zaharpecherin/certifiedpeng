class Like < ActiveRecord::Base

  def self.get_like_statistic(query, param, type=nil)
    @result = []
    param.each do |p|
      if type == 'urls'
        count = Like.where(tag_name: query, url: p).count
        like = Like.where(tag_name: query, url: p).order('created_at ASC').first
        hash = {tag_names: query, url: p, count: count, date: like.created_at.strftime("%d %b %Y") }
        @result.push(hash)
      else
        count = Like.where(tag_name: p, url: query, ).count
        like = Like.where(tag_name: p, url: query).order('created_at ASC').first
        hash = {tag_names: p, url: query, count: count, date:  like.created_at.strftime("%d %b %Y")}
        @result.push(hash)
      end
    end
     @result
  end

end
