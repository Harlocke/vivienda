class Saneamientosimagen < ActiveRecord::Base
  belongs_to :saneamiento
  belongs_to :user

  has_attached_file :saneamiento, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :saneamiento, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :saneamiento, :less_than => 10000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 10 Megabytes!!!'
end
