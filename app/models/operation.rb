class Operation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :activo, type: String
  field :broker, type: String
  field :fecha_entrada, type: Time
  field :precio_de_compra, type: Float
  field :unidades_compradas, type: Float
  field :stop_loss, type: Float
  field :posicion, type: String
  field :status, type: String
  field :comentario, type: String

  has_many :points
  has_many :refills
  has_many :take_profits

  belongs_to :wallet

  # @return [Array]
  def historial_transacciones
    (take_profits + refills).reject {|a| a.created_at.nil? }.sort {|a,b| a.fecha <=> b.fecha }
  end

  # @return [Float]
  def retiros
    take_profits.reduce(0.0) {|sum, tp| sum + tp.unidades * tp.price}
  end

  # @return [Float]
  def recargas
    refills.reduce(0.0) {|sum, refill| sum + refill.unidades * refill.price}
  end

  # @return [Point]
  def last_point
    points.order(updated_at: :desc).first
  end

  # @return [Float]
  def unidades_actuales # TODO: cambiar para que se consideren las compras y ventas de refill y take_profit
    unidades_compradas
  end

  # @return [Float]
  def precio_ponderado # TODO: cambiar para que se consideren las compras y ventas de refill y take_profit
    precio_de_compra
  end

  # @return [Float]
  def inversion_inicial
    return precio_de_compra * unidades_compradas
  end

  # @return [Float]
  def inversion
    return precio_ponderado * unidades_actuales
  end

  # @return [Float]
  def perdidaSl
    # (precio_de_compra * unidades_compradas) - (stop_loss * unidades_compradas)
    (precio_ponderado * unidades_actuales) - (stop_loss * unidades_actuales)
  end

  def riesgo
    perdidaSl / wallet.capitalizado
  end

end
