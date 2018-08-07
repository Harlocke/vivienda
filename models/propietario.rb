class Propietario < ActiveRecord::Base
  belongs_to :comuna
  has_many :ayudasviviendas

 # def to_param
 #   a = ("a".."z")
 #   s = ("A".."Z")
 #   b = (0..9)
 #   c = a.to_a + b.to_a + s.to_a+ b.to_a + b.to_a + s.to_a
 #   key = c.shuffle[0,15].join
 #   "#{id}!#{key}"
 # end

  validates_presence_of :identificacion, :primer_nombre, :primer_apellido, :direccion, :comuna_descripcion2,  :message => 'El campo no puede estar en blanco!!'
  validates_uniqueness_of :identificacion
  validates_length_of :identificacion, :in=> 6...11, :message=>"La identificación debe ser entre 6 y 11 digitos. Verifique!!"
  validates_numericality_of :identificacion
  validates_numericality_of :telefono1, :if => :in_us1?, :message=>"Debe ser numero!!"
  validates_numericality_of :telefono2, :if => :in_us2?, :message=>"Debe ser numero!!"
  validates_numericality_of :celular, :if => :in_us3?
  validate :telefons, :comuna_exist


  def telefons
    if self.telefono1.to_s == "" and self.telefono2.to_s == "" and self.celular.to_s == ""
      errors.add :telefono1, "Debe tener minimo 1 Telefono"
      errors.add :telefono2, "Debe tener minimo 1 Telefono"
      errors.add :celular, "Debe tener minimo 1 Telefono"
    end
  end

  def in_us1?
    self.telefono1.to_s != ""
  end

  def in_us2?
    self.telefono2.to_s != ""
  end

  def in_us3?
    self.celular.to_s != ""
  end

  def before_save
    identi = (self.identificacion.to_i).to_s.strip
    self.identificacion = identi
    nom =  ""
    if self.identificacion.nil? == false
      nom = self.identificacion.to_s
    end
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    self.autobuscar = nom
  end


  def self.search(search, page)
        paginate :per_page => 15,
                   :page => page,
                   :conditions => ["autobuscar like '%%#{(search.to_s)}%%'"],
                   :order => 'primer_nombre'
  end

  def telefonos
    tel =  ""
    if self.telefono1.nil? == false
      tel = tel + self.telefono1.to_s + " - "
    end
    if self.telefono2.nil? == false
      tel = tel + self.telefono2.to_s + " - "
    end
    if self.celular.nil? == false
      tel = tel + self.celular.to_s
    end
    return tel
  end

  def nombres
    nom =  ""
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    return nom
  end

  def comuna_exist
    if self.comuna_id
      if !Comuna.exists?(["id = #{self.comuna_id}"])
         errors.add :comuna_descripcion2, "* El barrio no es valido"
      end
    else
      errors.add :comuna_descripcion2, "* El barrio no es valido"
    end
  end   
  
  def comuna_descripcion2
    comuna.descripcion2 if comuna
  end

  def comuna_descripcion2=(descripcion2)
    self.comuna = Comuna.find_or_create_by_descripcion2(descripcion2) unless descripcion2.blank?
  end

end
