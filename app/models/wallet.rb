class Wallet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nombre, type: String
  field :capital_inicial, type: Float

  def capitalizado
  end

  def valorActualActivos
  end

  def capitalDisponible
  end

  def porcentajeEnOperacion
  end

  def flotanteTotal
  end

  def totalDineroEnRiesgo
  end



  has_many :operations
end
