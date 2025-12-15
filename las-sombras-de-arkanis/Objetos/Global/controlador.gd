extends Node

# Define la señal para que otros scripts puedan escucharla
signal selecEnemigo
signal ataqueIniciado
var turnoJugador : bool = true
var menuAbierto : bool = true  

var pSelecionado
var pObjetivo

func cambiarTurno():
	turnoJugador = not turnoJugador
	
func empezarAtaque():
	menuAbierto = false
	selecEnemigo.emit() 

func establecerPersonaje(personaje):
	pSelecionado = personaje

func establecerEnemigo(personaje):
	pObjetivo = personaje

func iniciarAtaque():
	emit_signal("ataqueIniciado")
	pSelecionado.atacarPersonaje(pObjetivo)
