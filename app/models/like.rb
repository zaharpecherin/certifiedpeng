class Like < ActiveRecord::Base

  scope :get_statistic, -> { select("COUNT(*) AS like_count, url, tag_name, MIN(created_at) AS created_at, string_agg(country, ', ') AS countries").group(:url, :tag_name).order('like_count DESC') }

  def self.set_location(like_page)
    country = Geocoder.search(like_page.ip).first.try(:country) || 'NA'
    like_page.update_attribute(:country, country)
  end

  def self.search_request(query)
    return unless query
    search = where(tag_name: query)
    if search.any?
      urls =  search.select(:url).group(:url).pluck(:url)
      get_like_statistic(query, urls, 'tag')
    else
      search =  where(url: query)
      tag_names = search.select(:tag_name).group(:tag_name).pluck(:tag_name)
      get_like_statistic(query, tag_names, 'url')
    end
  end

  private

  def self.get_like_statistic(query, param, type)
    result = []
    param.each do |p|
      url = type == 'url' ? query : p
      tag_name = type == 'url' ? p : query
      count = where(tag_name: tag_name, url: url).count
      like = where(tag_name: tag_name, url: url).order('created_at ASC').first
      hash = {tag_names: tag_name, url: url, count: count, date:  like.created_at.strftime('%d %b %Y')}
      result.push(hash)
    end
    result
  end
end
