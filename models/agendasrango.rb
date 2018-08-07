class Agendasrango < ActiveRecord::Base
  belongs_to :agendasproceso
  belongs_to :user
  has_many :agendasfechas, :dependent =>:destroy

  validates_presence_of :fecha_inicio,:fecha_fin

  def after_create
    if self.id
      objs = Objeto.find_by_sql(["select placa fecha, decode(to_char(placa,'d'),'2','LUNES','3','MARTES','4','MIERCOLES','5','JUEVES','6','VIERNES') dia from fechas
             where placa between '#{self.fecha_inicio.to_date}' and '#{self.fecha_fin.to_date}'
             minus
             select fecha, decode(to_char(fecha,'d'),'2','LUNES','3','MARTES','4','MIERCOLES','5','JUEVES','6','VIERNES') from festivos
             order by fecha"])
      objs.each do |obj|
      	#logger.error("Dato inicio..."+obj.dia.to_s+" ---- "+obj.fecha.to_s)
      	dato = Agendasparametro.find_by_agendasproceso_id_and_dia(self.agendasproceso_id,obj.dia)
      	if dato
      		#logger.error("Ingreso el dia....."+dato.dia.to_s)
	        a = Agendasfecha.new
	        a.agendasproceso_id = self.agendasproceso_id
	        a.fecha  = obj.fecha
	        a.estado = 'ACTIVO'
	        a.hora_inicio = dato.hora_inicio
	        a.hora_fin = dato.hora_fin
	        a.intervalo = dato.intervalo
	        a.cantidad = dato.cantidad
	        a.agendasrango_id = self.id
	        a.save
	      end
      end
    end
  end

end

=begin

  AGENDASPROCESO_ID NUMBER(38),
  FECHA             DATE,
  ESTADO            VARCHAR2(255 CHAR),
  CREATED_AT        DATE,
  UPDATED_AT        DATE,
  HORA_INICIO       VARCHAR2(255 CHAR),
  HORA_FIN          VARCHAR2(255 CHAR),
  INTERVALO         NUMBER(38),
  CANTIDAD          NUMBER(38)


  
  for l1 in (select placa fecha, decode(to_char(placa,'d'),'1','LUNES','2','MARTES','3','MIERCOLES','4','JUEVES','5','VIERNES') dia from fechas
             where placa between dtFchInicio and dtFchFin
             minus
             select fecha, decode(to_char(fecha,'d'),'1','LUNES','2','MARTES','3','MIERCOLES','4','JUEVES','5','VIERNES') from festivos
             order by fecha) loop
    begin
      select intervalo, cantidad, hora_inicio, hora_fin
      into   nmIntervalo, nmCantidad, vcInicio, vcFin
      from   agendasparametros where agendasproceso_id = nmAgendasprocesoId;
    end;
                 
  
  end loop;


=end