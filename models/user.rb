class User < ActiveRecord::Base
  acts_as_authentic
#  acts_as_authentic do |c|
#    c.logged_in_timeout(1.minutes)
#  end
  has_many :personas
  has_many :personasarrendamientos
  has_many :moravias
  belongs_to :dependencia
  has_many :actividades
  has_many :notifications
  has_many :inmobiliarios
  has_many :viviendasreportes
  has_many :usersmodulos, :dependent =>:destroy
  has_many :userspermisos, :dependent =>:destroy
  has_many :usersproyectos, :dependent =>:destroy
  has_many :usersdatos
  has_many :usersinventarios
  has_many :resoluciones
  has_many :archivos
  has_many :obraspublicas
  has_many :obrasobservaciones
  has_many :obrasvendedores
  has_many :obrasradicados
  has_many :obrasdisponibilidades
  has_many :iguanasestadosnotas
  has_many :ayudas
  has_many :ayudasviviendas
  has_many :ayudaspagos
  has_many :ayudasnovedades
  has_many :ayudasobservaciones
  has_many :ayudasfichas
  has_many :ayudastalleres
  has_many :contratosobservaciones
  has_many :elementosmantenimientos
  has_many :elementosusers
  has_many :elementosimagenes
  has_many :comitesobservaciones
  has_many :comitesactividades
  has_many :comitesusers
  has_many :comitesresponsables
  has_many :correspondenciasrecibidasusers
  has_many :elementos
  has_many :calidadprocesos
  has_many :titulacionesasignaciones
  has_many :titulacionespersonasnotas
  has_many :archivosactualizaciones
  has_many :mejoramientosconceptos
  has_many :almacenesentradas
  has_many :conveniosmejoramientos
  has_many :conveniosresoluciones
  has_many :elementosotros
  has_many :mejorainformes
  has_many :quejassoportes
  has_many :interactividades
  has_many :interventorias
  has_many :interactobservaciones
  has_many :interactimagenes
  has_many :titulaciones
  has_many :titulacionesvisitas
  has_many :proyectoscopdocumentos
  has_many :corvidesobservaciones
  has_many :corvidespersonas
  has_many :corvidesdocumentos
  has_many :proyectoscopnotas
  has_many :proyectos
  has_many :repartos
  has_many :repartosactos
  has_many :repartosinmuebles
  has_many :contratosinterventorias
  has_many :empleadobitacoras
  belongs_to :gestion

  named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[admin tramites planeacion censo]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def self.search(search, page)
      paginate :per_page => 15,
                 :page => page,
                 :conditions => ["nombre like '%%#{replacespace(search.to_s)}%%'"],
                 :order => 'nombre'
  end

  def after_create
    habilitadas = Sifi.find(91).valor.to_s
    habilitadas.split(",").map { |s| 
      usersmodulo = Usersmodulo.new
      usersmodulo.user_id = self.id
      usersmodulo.modulo_id = s.to_i
      usersmodulo.save      
    }
  end

  def self.replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end

  def responsable
    @nombre = self.nombre.to_s + ' ('+ self.email.to_s+')'
    return @nombre
  end

  def responsablenombre
    @nombre = self.nombre.to_s
    return @nombre
  end


  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
  
end
