const actualizarFila = (activo, price) => {
  console.log("actualizarFila")
}

function actualizarPreciosTable() {
  console.log("============= actualizarPreciosTable")
  const activos = document.querySelectorAll('.data-activo')
  activos.forEach(activo => {
    const nombre_activo = activo.querySelector('.nombre-activo')
    fetch(`https://api3.binance.com/api/v3/ticker/price?symbol=${nombre_activo.innerText}`)
      .then(data => {return data.json()})
      .then(({price}) => {
        activo.querySelector('.price').innerText = price
      })
  })
}

actualizarPreciosTable()