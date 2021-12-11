# Visión General

Rastreador de portfolio es una aplicación web que busca rastrear las ganancias y pérdidas que
le van generando las operaciones que uno va efectuando en su portfolio de inversiones.

Los datos que se deben calcular son los siguientes:

## Modelo Wallet

- nombre: nombre de la wallet, solo para identificarla.
- capital_inicial: cantidad de dinero con la que comienza la wallet. Si después se agregan o quitan fondos, deben sumarse o restarse a este valor
- capitalizado: corresponde al capital inicial más las pérdidas y ganancias de las operaciones cerradas completamente o parcialmente
- valorActualActivos: corresponde al capitalizado sumado a los valores flotantes de cada operación de la wallet
- capitalDisponible: es lo que se tiene disponible para operar
- porcentajeEnOperacion: de las operaciones corriendo, a cuanto equivalen del capital inicial
- flotanteTotal: es el flotante de todas las operaciones sumado
- totalDineroEnRiesgo: es el total de dinero que está en riesgo

## Operation

- activo: es el nombre del activo. Tiene que poner exactamente lo que aparece en el ticker
de binance, ya que se está haciendo uso de la API de Binance para tomar el precio en tiempo real del activo
- broker: por el momento solo está soportado el broker de Binance
- fecha_entrada: corresponde al timestamp de la fecha de entrada
- precio_de_compra: precio al cual se ejecutó la operación
- unidades_compradas: unidades compradas en la operación
- stop_loss: punto en el cual la operación se cancelará si el precio alcanza ese valor. Si uno entra en LONG, este punto debe estar por debajo del precio de entrada, y si uno entra en SHORT, este punto debe estar por encima del precio de entrada
- posicion: corresponde a LONG o SHORT
- status: puede tener uno de estos valores:
  - ABIERTA: es el estado inicial, la operación está abierta tanto hacia arriba como hacia abajo: si se va en contra va a tomar el stop loss, y si se va a favor podría alcanzar un target.
  - BE: significa Break Even, usualmente cuando el precio va a favor de la operación pero aún no alcanza un target, el stop loss se sube al precio de entrada. De esta forma si el mercado se va en contra, sacará la operación en el punto de entrada sin generarnos pérdidas.
  - PARCIAL: el mercado se ha movido a favor de la operación, y ha sacado ganancias parciales.
  - SL: Stop Loss, el mercado se ha movido en contra y ha sacado la operación con pérdidas.
  - CERRADA: La operación se encuentra cerrada, ya sea porque se alcanzaron todos los targets, o la operación se ha salido en Break Even. Pero una operación cerrada en el fondo es la que no le quedan unidades compradas.
- comentario: algun comentario que se quiera dejar registrado sobre la operación.

# Para cranear

## Modelos y donde guardar los valores

¿Cuáles son los valores que debo guardar en el modelo wallet y en el modelo operation?

En los modelos de wallet y operation solo deberían guardarse los valores estrictamente ligados a lo que es una wallet y lo que es operation.

Por ejemplo, cuando se toma el precio en tiempo real de un activo, y se calcula el flotante y todos los valores relacionados con el precio actual (porcentaje de avance, etc). Esos calculos no corresponden al modelo de wallet ni al modelo de operation, si no que al modelo "point" que es un punto en el tiempo del valor del activo.

También podemos incorporar dos modelos más: refill y take_profit. Una operación tiene muchos refills y tiene muchos take_profits, y un refill pertenece a una operación, y un take_profit pertenece a una operación. El modelo refill corresponde a una recarga de dinero que se hace a una operación (por ejemplo su valor ha bajado del punto de entrada y queremos comprar más), y el modelo take_profit es un retiro parcial de la operación.

## Variables independientes y dependientes (o computados)

Esta es la parte más peligrosa de la aplicación. En matemática se le dice variable independiente a lo que se representa en el eje X. La variable independiente es la que se maneja a si misma, que no depende de otras cosas. En cambio la variable dependiente es la que cambia en función de la variable independiente.

También se puede llamar valor computado a la variable dependiente, o en matemáticas la que corresponde al eje Y. Se le puede llamar valor computado porque es un valor que se calcula a partir de las variables independientes. Se meten en la juguera el valor capitalizado de la wallet, y los puntos de entrada, unidades compradas y stop loss de cada operación, y después de batir revolver y mezclar esos valores independientes, se obtiene como valor computado (o dependiente) el porcentaje de dinero que está en riesgo, las pérdidas en caso de desastre, etc, etc.

Hay que diferenciar entre los valores computados y los valores independientes porque si se guardan ambos en la base de datos, podemos entrar en el problema de ¿quien manda? ¿el valor computado o el valor independiente? Claro que el que manda es el valor independiente, pero qué hago si veo que un valor está actualizado. ¿Cuándo debo volver a actualizarlo? Es complicado, en cambio si los valores computados no se guardan en la base de datos, entonces cada vez que los pida los calcularé a partir de las variables independientes, y con eso siempre los valores computados estarán al día. El problema que trae esto es que puede ser muy exigente para la máquina y se ponga lenta la aplicación. Por eso hay que cranear todo esto



