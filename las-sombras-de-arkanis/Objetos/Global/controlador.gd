extends Node

# Define la señal para que otros scripts puedan escucharla
signal selecEnemigo

var turnoJugador : bool = true
var menuAbierto : bool = true  

var pSelecionado: Personaje
var pObjetivo: Personaje

func cambiarTurno():
	turnoJugador = not turnoJugador
	
func empezarAtaque():
	menuAbierto = false
	selecEnemigo.emit() 

func establecerPersonaje(personaje : Personaje):
	pSelecionado = personaje

func establecerEnemigo(personaje: Personaje):
	pObjetivo = personaje
