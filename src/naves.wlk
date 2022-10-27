class Nave{
	var property velocidad = 0
	
	method acelerar(cantidad){
		velocidad = (velocidad + cantidad).min(300000)
	}
	
	method propulsar(){
		self.acelerar(20000)
	}
	
	method preparar(){ 
		self.acelerar(15000)
	}
	
	//Template Method, las subclases se encargan de ser necesario solo de B y C
	method encontrarEnemigo() { //A
		self.recibirAmenaza() //B
		self.propulsar() //C
	}
	
	method recibirAmenaza() //Método abstracto, se debe definir con override en sus subclases 
							//si queda abstracto en las mismas no se puede instanciar (clase abstracta)

}



class NaveDeCarga inherits Nave{
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
}

class NaveDeResiduosRadiactivos inherits NaveDeCarga{
	var sellado = false
	
	method sellar(){
		sellado = true
		velocidad = 0
	}
	
	method sellado(){
		return sellado
	}

	override method recibirAmenaza() {
		self.sellar()
		//velocidad = 0 //Ya lo realiza sellar().
	}
	
	override method preparar(){
		self.sellar()
		super() 
	}
}

class NaveDePasajeros inherits Nave{
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
}

class NaveDeCombate inherits Nave{
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

	override method recibirAmenaza() {
		modo.recibeAmenaza(self)
	}
	
	override method preparar(){
		super()
		modo.preparar(self)
	}
}

object reposo {

	method invisible(nave) = nave.velocidad() < 10000

	method recibeAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
	
	method preparar(nave){
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)
	}
}

object ataque {

	method invisible(nave) = not nave.armasDesplegadas()

	method recibeAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
		nave.activarArmas()
	}
	
	method preparar(nave){
		nave.emitirMensaje("Volviendo a la base")
	}
}


