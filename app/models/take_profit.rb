class TakeProfit
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: String, default: "TAKEN"
  field :name, type: String
  field :unidades, type: Float
  field :price, type: Float
  field :fecha, type: DateTime

  belongs_to :operation

  after_initialize :generate_name

  protected

    def generate_name
      return nil if self.operation.nil?
      self.name = "TP#{self.operation.take_profits.count + 1}"
    end
end
