class Wallet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nombre, type: String
  field :capital_inicial, type: Float

  has_many :operations

  # @return [Float]
  def capitalizado
    self.operations.order(fecha_entrada: :asc).reduce(self.capital_inicial) {|sum, o| sum + o.retiros - o.recargas}
  end

  # @return [Float]
  def valorActualActivos
    operations.order(fecha_entrada: :asc).reduce(capitalizado) {|sum, o| sum + (o.last_point.nil? ? 0.0 : o.last_point.flotante)}
    # return 0.0
  end

  # @return [Float]
  def capitalDisponible
    operations.order(fecha_entrada: :asc).reduce(capitalizado) {|sum, o| sum - o.inversion }
  end

  def porcentajeEnOperacion
  end

  # @return [Float]
  def flotanteTotal
    operations.order(fecha_entrada: :asc).reduce(0.0) {|sum, o| sum + (o.last_point.nil? ? 0.0 : o.last_point.flotante)}
  end

  # @return [Float]
  def riesgoGlobal
    operations.reduce(0.0) { |sum, o| sum + o.riesgo }
  end

  # @return [Float]
  def totalDineroEnRiesgo
    operations.reduce(0.0) { |sum, o| sum + o.perdidaSl }
  end



end
