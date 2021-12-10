class Wallet
  include Mongoid::Document
  include Mongoid::Timestamps
  field :capital_inicial, type: Float
end
