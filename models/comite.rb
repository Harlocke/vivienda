class Comite < ActiveRecord::Base
  has_many :comitesactividades
  has_many :comitesobservaciones
  has_many :comitesusers
  has_many :comitesimagenes
  has_many :comitesresponsables
  belongs_to :comitestipo

  validates_presence_of :fecha, :comitestipo_id, :temas

  def self.mensaje(comite)
    dependencias = Dependencia.find(:all,:conditions=>["id in (select distinct dependencia_id from comitesactividades where comite_id = #{comite.id})"])
    dependencias.each do |y|
      users  = User.find(:all, :conditions => ["id in (select user_id
                                                       from   mensajesusers
                                                       where  mensaje_id = #{y.mensaje_id})"])
      users.each do |x|
        comitesactividades = Comitesactividad.find(:all, :conditions=>["comite_id = #{comite.id} and dependencia_id = #{y.id}"])
        comitesobservaciones = Comitesobservacion.find(:all, :conditions=>["comite_id = #{comite.id}"],:order => 'created_at ASC')
        Notifier.deliver_comite_message(x,comite,comitesactividades,comitesobservaciones)
      end
    end
  end

  def self.invitacion(comite)
      users  = User.find(:all, :conditions => ["id in (select user_id
                                                       from   comitesresponsables
                                                       where  comite_id = #{comite.id})"])
      users.each do |x|
        comitesresponsables = Comitesresponsable.find(:all, :conditions=>["comite_id = #{comite.id}"],:order => 'created_at ASC')
        Notifier.deliver_invitacion_message(x,comite,comitesresponsables)
      end
  end

  def self.mensajejefe(comite)
    y = Dependencia.find(10000)
      users  = User.find(:all, :conditions => ["id in (select user_id
                                                       from   mensajesusers
                                                       where  mensaje_id = #{y.mensaje_id})"])
      users.each do |x|
        comitesactividades = Comitesactividad.find(:all, :conditions=>["comite_id = #{comite.id}"])
        comitesobservaciones = Comitesobservacion.find(:all, :conditions=>["comite_id = #{comite.id}"],:order => 'created_at ASC')
        comitesusers = Comitesuser.find(:all, :conditions=>["comite_id = #{comite.id}"])
        Notifier.deliver_comitejefe_message(x,comite,comitesactividades,comitesobservaciones,comitesusers)
      end
  end

  def self.search (creainicial,creafinal,comitestipo_id,temas,vencinicial,vencfinal,nrocomision,concejal,valor)
      cadena = ""
      if creainicial.to_s != "" and creafinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
        else
          cadena = cadena + ' fecha between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
        end
      end
      if comitestipo_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and comitestipo_id = '+ "'#{comitestipo_id}'"
        else
          cadena = cadena + ' comitestipo_id = '+ "'#{comitestipo_id}'"
        end
      end
      if temas.to_s != ""
        if cadena != ""
          cadena = cadena + ' and temas like '+ "'%%#{temas.to_s}%%'"
        else
          cadena = cadena + ' temas like '+ "'%%#{temas.to_s}%%'"
        end
      end
      if vencinicial.to_s != "" or vencfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id  in (select comite_id
                                          from   comitesactividades
                                          where  fecha_limite  between ' + "'#{vencinicial}'" + ' and ' + "'#{vencfinal}'" +')'
        else
          cadena = cadena + ' id  in (select comite_id
                                          from   comitesactividades
                                          where  fecha_limite  between ' + "'#{vencinicial}'" + ' and ' + "'#{vencfinal}'" +')'
        end
      end
      if nrocomision.to_s != ""
        s = nrocomision.to_s.upcase
        if cadena != ""
          cadena = cadena + ' and nro_comision = '+ "'#{s.to_s.strip}'"
        else
          cadena = ' nro_comision = '+ "'#{s.to_s.strip}'"
        end
      end
      if concejal.to_s != ""
        s = concejal.to_s.upcase
        if cadena != ""
          cadena = cadena + ' and concejal like '+ "'%%#{s.to_s}%%'"
        else
          cadena = cadena + ' concejal like '+ "'%%#{s.to_s}%%'"
        end
      end
      if cadena != ""
        if valor.to_s == 'C'
          cadena = cadena + " and comitestipo_id in (select id from comitestipos where comision = 'S')"
        end
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        if valor.to_s == 'C'
          find(:all, :conditions => ["trunc(created_at) = trunc(sysdate) and comitestipo_id in (select id from comitestipos where comision = 'S')"], :order => "created_at")
        else
          find(:all, :conditions => ["trunc(created_at) = trunc(sysdate)"], :order => "created_at")
        end
      end
  end

end
