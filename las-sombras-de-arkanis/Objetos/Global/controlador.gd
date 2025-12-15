extends Node

# Define la señal para que otros scripts puedan escucharla
signal selecEnemigo
signal ataqueIniciado
var turnoJugador : bool = true
var menuAbierto : bool = true  

var pSelecionado
var pObjetivo

var enemigos = []
var turnoEnemigo: int =0
var jugadores = []


func obtener_personajes():
	
	enemigos = get_tree().get_nodes_in_group("Enemigo")
	jugadores = get_tree().get_nodes_in_group("Jugador")

func cambiarTurno():
	obtener_personajes()
	turnoJugador = !turnoJugador
	if turnoJugador==false:
		iniciarTurnoEnemigo()
	
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

func iniciarTurnoEnemigo ():
	if enemigos.is_empty():
		print("Batalla terminada: No quedan enemigos.")
		
		return
		

	turnoEnemigo = turnoEnemigo % enemigos.size() 
	
	# Ahora accedemos al enemigo de forma segura
	var enemigo_actual = enemigos[turnoEnemigo]
	establecerPersonaje(enemigo_actual)
	establecerEnemigo(jugadores.pick_random())
	iniciarAtaque()
	cambiarTurno()
	
