class Wallet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nombre, type: String
  field :capital_inicial, type: Float

  has_many :operations

  # @return [Float]
  def capitalizado
    self.operations.order(fecha_entrada: :asc).reduce(self.capital_inicial) {|sum, o| sum + (o.last_point.nil? ? 0.0 : o.retiros)}
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



end
