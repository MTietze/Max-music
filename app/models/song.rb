class Song < ActiveRecord::Base
  
  def self.search(search)
    if search
      search.downcase!
      where('year = ? OR lower(title) LIKE ? OR lower(artist) LIKE ?', search.to_i, "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end

