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
  belongs_to :wallet

end
