class Fiduciasimagen < ActiveRecord::Base
  belongs_to :fiduciascontrato
  belongs_to :user
  
  has_attached_file :doc, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :doc, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :doc, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

   def descripcion_mes
  	if self.mes.to_s == "1"
  		return "ENERO"
  	elsif self.mes.to_s == "2"
  		return "FEBRERO"
  	elsif self.mes.to_s == "3"
  		return "MARZO"
  	elsif self.mes.to_s == "4"
  		return "ABRIL"
  	elsif self.mes.to_s == "5"
  		return "MAYO"
  	elsif self.mes.to_s == "6"
  		return "JUNIO"
  	elsif self.mes.to_s == "7"
  		return "JULIO"
  	elsif self.mes.to_s == "8"
  		return "AGOSTO"
  	elsif self.mes.to_s == "9"
  		return "SEPTIEMBRE"
  	elsif self.mes.to_s == "10"
  		return "OCTUBRE"
  	elsif self.mes.to_s == "11"
  		return "NOVIEMBRE"
  	elsif self.mes.to_s == "12"	
  		return "DICIEMBRE"
    elsif self.mes.to_s == "99" 
      return "OTROS"
  	else
  		return "__________"
  	end
  end
end
