class NaveDeCarga {

	var velocidad = 0
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros {

	var velocidad = 0
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate {
	var property velocidad = 0
	var property modo = reposo
	var property armasDesplegadas = false
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method activarArmas() {
		armasDesplegadas = true
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = modo.invisible(self)

	method recibirAmenaza() {
		modo.recibeAmenaza(self)
	}

}

object reposo {

	method invisible(nave) = nave.velocidad() < 10000

	method recibeAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible(nave) = not nave.armasDesplegadas()

	method recibeAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
		nave.activarArmas()
	}

}

