class Reparto < ActiveRecord::Base
	has_many :repartosactos
	has_many :repartosinmuebles
	belongs_to :notaria

  def estadopareenvio
  	if self.repartosactos.exists? and self.repartosinmuebles.exists?
  	 	return true
  	else
  		return false
  	end
  end

  def self.search(search, page)
    if search.to_s == ""
      paginate :per_page => 15,
                 :page => page,
                 :order => 'created_at desc'
    else
      paginate :per_page => 15,
                 :page => page,
                 :conditions => ["nro_acta = '#{search.to_s}'"],
                 :order => 'created_at desc'
    end
  end  

  def matriculas
    mat = ""
    i = 0
    for repartosinmueble in self.repartosinmuebles.find(:all,:conditions=>["vivienda_id is not null"], :order => 'created_at DESC')
      if i == 0
        mat = repartosinmueble.vivienda.nro_matricula.to_s
        i = i + 1
      else
        mat = mat + ', ' + repartosinmueble.vivienda.nro_matricula.to_s
      end
    end
    for repartosinmueble in self.repartosinmuebles.find(:all,:conditions=>["corvide_id is not null"], :order => 'created_at DESC')
      if i == 0
        mat = repartosinmueble.corvide.matricula.to_s
        i = i + 1
      else
        mat = mat + ', ' + repartosinmueble.corvide.matricula.to_s
      end
    end
    for repartosinmueble in self.repartosinmuebles.find(:all,:conditions=>["corvide_id is null and vivienda_id is null"], :order => 'created_at DESC')
      if i == 0
        mat = repartosinmueble.matricula.to_s
        i = i + 1
      else
        mat = mat + ', ' + repartosinmueble.matricula.to_s
      end
    end
    return mat
  end

  def actos
    mat = ""
    i = 0
    for repartosacto in self.repartosactos.find(:all, :order => 'created_at DESC')
      if i == 0
        mat = repartosacto.tiposacto.descripcion.to_s
        i = i + 1
      else
        mat = mat + ', ' + repartosacto.tiposacto.descripcion.to_s
      end
    end
    return mat
  end 

  def self.searchreparto (zona, fchinicial, fchfinal)
      cadena = ""
      if zona.to_s != ""
        if cadena != ""
          cadena = cadena + " and zona = '#{zona.to_s}'"
        else
          cadena = " zona = '#{zona.to_s}'"
        end
      end
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(fecha_reparto) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
        else
          cadena = ' trunc(fecha_reparto) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "id")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
      end
  end  

  def self.searchrepartomas (zona, fchinicial)
      cadena = ""
      if zona.to_s != ""
        if cadena != ""
          cadena = cadena + " and zona = '#{zona.to_s}'"
        else
          cadena = " zona = '#{zona.to_s}'"
        end
      end
      if fchinicial.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(fecha_reparto) = ' + "'#{fchinicial.to_date}'" 
        else
          cadena = ' trunc(fecha_reparto) = ' + "'#{fchinicial.to_date}'" 
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "id")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
      end
  end  

end
