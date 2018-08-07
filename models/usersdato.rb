class Usersdato < ActiveRecord::Base

  belongs_to :user

  def self.buscar(buscarnombre)
    s = buscarnombre.upcase
    find(:all, :conditions => ["user_id in (select id from users where nombre like ? and activo ='S')", "%#{s.to_s}%"])
  end

  def self.search(search, page)
    if search == nil
      paginate :per_page => 10, :page => page, :conditions => ["user_id = -1"]
    else
      if search != ""
        s = search.upcase
        paginate :per_page => 10, :page => page, :conditions => ["user_id in (select id from users where nombre like '%%#{replacespace(s.to_s.strip)}%%' and activo ='S')"]
      end
    end
  end

  has_attached_file :userfoto, :styles => { :medium => "300x300!", :thumb => "100x100!", :little => "60x60!" }, :default_url => "user.png", :whiny => false

  def self.replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end

end
