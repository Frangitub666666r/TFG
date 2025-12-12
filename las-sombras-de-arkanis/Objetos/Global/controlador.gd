extends Node
signal selecEnemigo()
var turnoJugador : bool=true
var menuAbierto : bool = true


func cambiarTurno():
	turnoJugador !=turnoJugador
	
func empezarAtaque():
	menuAbierto=false
	emit_signal("selecEnemigo")
	
