class Wallet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nombre, type: String
  field :capital_inicial, type: Float
  field :capitalizado, type: Float, default: 0.0
  field :valor_actual_activos, type: Float, default: 0.0
  field :capital_disponible, type: Float, default: 0.0
  field :porcentaje_en_operacion, type: Float, default: 0.0
  field :flotante_total, type: Float, default: 0.0
  field :flotante_total_sl, type: Float, default: 0.0

  has_many :operations
end
