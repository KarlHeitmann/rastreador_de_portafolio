class Point
  include Mongoid::Document
  include Mongoid::Timestamps

  field :actual_price, type: Float
  field :flotante, type: Float

  belongs_to :operation

  after_build :calculus

  def calculus
    self.flotante = operation.unidades_compradas * actual_price - operation.unidades_compradas * operation.precio_de_compra
  end
end
