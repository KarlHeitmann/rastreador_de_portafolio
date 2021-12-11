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

  def riesgo
  end

end
