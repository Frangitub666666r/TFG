extends Node

signal selecEnemigo()
signal ataqueIniciado()
signal cambiar_Turno(jugador: bool)


var turnoJugador : bool = true
var menuAbierto : bool = true  

var pSelecionado
var pObjetivo

var enemigos = []
var turnoEnemigo: int =0
var jugadores = []
var Fin: bool = false

func obtener_personajes():
	
	enemigos = get_tree().get_nodes_in_group("Enemigo")
	jugadores = get_tree().get_nodes_in_group("Jugador")
	
	if enemigos.size()==0:
		print("ganaste")
		Fin=true
	if jugadores.size()==0:
		print("Has perdido")
		Fin=true

func cambiarTurno():
	
	obtener_personajes()
	turnoJugador = !turnoJugador
	emit_signal("cambiar_Turno", turnoJugador)
	
	if turnoJugador==false:
		await get_tree().create_timer(1).timeout
		if Fin:
			return
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

func defenderPersonaje():
	pSelecionado.defenserse()

func iniciarTurnoEnemigo ():
	if turnoEnemigo>= enemigos.size():
		turnoEnemigo=0

	if enemigos.is_empty():
		print("Batalla terminada: No quedan enemigos.")
		
		return
		

	turnoEnemigo = turnoEnemigo % enemigos.size() 
	
	# Ahora accedemos al enemigo de forma segura
	var enemigo_actual = enemigos[turnoEnemigo]
	establecerPersonaje(enemigo_actual)
	establecerEnemigo(jugadores.pick_random())
	iniciarAtaque()
	turnoEnemigo+=1
	
