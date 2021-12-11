namespace :ejemplos do
  desc "Genera una wallet y una operacion de ejemplo"
  task bit: :environment do
    wallet = Wallet.create(nombre: "ejemplo", capital_inicial: 1000.0)
    operation = wallet.operations.build(
      activo: "BTCUSDT",
      broker: "BINANCE",
      fecha_entrada: 1.day.ago,
      precio_de_compra: 40000.0,
      unidades_compradas: 0.001,
      stop_loss: 35000,
      posicion: "LONG",
      status: "ABIERTA",
      comentario: "Esta es una operación de ejemplo"
    )
    operation.save
  end
end