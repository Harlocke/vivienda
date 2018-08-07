class Calidaddocumentosimagen < ActiveRecord::Base
  belongs_to :calidaddocumento
  belongs_to :user

  has_attached_file :calidaddocumento, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :calidaddocumento, :message => 'Debe seleccionar un archivo valido!!'
  
  validate :nombre

  def nombre
    if Objeto.exists?([" '#{self.calidaddocumento_file_name.to_s}' like '%%Á%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%É%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%Í%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%Ó%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%Ú%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%á%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%é%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%í%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%ó%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%ú%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%Ñ%%'
                        or '#{self.calidaddocumento_file_name.to_s}' like '%%ñ%%'"]) == true
       errors.add :calidaddocumento, "* El nombre del archivo no puede tener tildes"
    end
  end

end
