module QuejasHelper

  def select_queja
    [
      ["QUEJA","QUEJA"],
      ["RECLAMO","RECLAMO"],
      ["SUGERENCIA","SUGERENCIA"],
      ["SOLICITUD","SOLICITUD"],
      ["CONSULTA","CONSULTA"],
      ["INFORMACION","INFORMACION"],
      ["PETICION","PETICION"],
      ["DENUNCIA","DENUNCIA"]
    ]
  end

  def select_quejainicial
    [
      ["PETICION","PETICION"],
      ["QUEJA","QUEJA"],
      ["RECLAMO","RECLAMO"],
      ["SUGERENCIA","SUGERENCIA"],
      ["DENUNCIA","DENUNCIA"]
    ]
  end
end
