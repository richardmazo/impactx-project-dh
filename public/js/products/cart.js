if (document.readyState == "loading") {
  document.addEventListener("DOMContentLoaded", ready);
} else {
  ready();
}

let productos = JSON.parse(localStorage.getItem("carrito")) || [];

function ready() {
  if (!JSON.parse(!localStorage.getItem("carrito"))) {
    localStorage.setItem("carrito", JSON.stringify([]));
  }
  mostrarCarrito(productos);
}

function borrarElemento(id) {
  // Filtrar los elementos cuyo ID no coincide con el proporcionado
  productos = productos.filter((row) => row.id != id);
  mostrarCarrito(productos);
  // Actualizar los productos en el localStorage
  localStorage.setItem("carrito", JSON.stringify(productos));
}

function vaciarCarrito() {
  //tengo que setar en el localstorage el array vacio
  mostrarCarrito([]);
}

async function finalizarCompra() {
  let data = {
    total: productos.reduce((acum, current) => acum + current.precio, 0),
    productos: productos,
  };
  let finalizarFetch = await fetch("/cart/done", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  let response = await finalizarFetch.json();
  console.log(response);
}

function mostrarCarrito(productosCarrito) {
  let carritoProd = document.querySelector(".carrito-prod");
  if (productosCarrito.length == 0) {
    carritoProd.innerHTML = `<h2>The cart is empty <a href='/productos'>¡Buy now!</a></h2>`;
    document.querySelector(".mainTotal").innerHTML = ``;
  } else {
    let subTotal = 0;
    carritoProd.innerHTML = ``;
    productosCarrito.forEach((element) => {
      subTotal += parseInt(element.precio);
      carritoProd.innerHTML += `<article class="tarjetaCart">
      <div class="containerImagenCart">
        <img class="cartImagen" src="/img/${element.img}">
      </div>

      <div class="containerInfoCart">
        <h2 class="name">${element.nombre}</h2>
        <p class="price">${element.precio} $</p>
        <p class="description">${element.description}</p>

        <div class="contenedorBotonesCart">
          <button type="sumbit" class="botonCart eliminar" onClick=borrarElemento(${element.id})>X</button>
        </div>
      </div>

    </article>`;
    });
    document.querySelector(
      ".mainTotal"
    ).innerHTML = `<div class="containerInfoCart">
    <p class="price">Envio $ 1.500</p>
    <p class="price">Subtotal ${subTotal}</p>
    <h2 class="name">Total ${subTotal + 1500}</h2>
  </div>
  <div iv class="nuevoCart">
    <button type="sumbit" class="botonCart edit" onClick=finalizarCompra()>Confirmar compra</button>
    <button type="sumbit" class="botonCart edit" onClick=vaciarCarrito()>Vaciar carrito</button>
  </div>`;
  }
}
