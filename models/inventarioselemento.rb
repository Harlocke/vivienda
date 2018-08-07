class Inventarioselemento < ActiveRecord::Base

  has_many :usersinventarios

  def self.search(search, page)
    if search.to_s != ""
      s = search.upcase
    end
      paginate :per_page => 10,
               :page => page,
               :conditions => ['descripcion like ? ', "%#{s.to_s.strip}%"],
               :order => 'descripcion'
  end

end
