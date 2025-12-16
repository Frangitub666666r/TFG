extends Node2D


func _ready() -> void:
	Controlador.connect("cambiar_Turno", actualizarTurno)

func _on_iniciar_mundo_timeout() -> void:
	Controlador.obtener_personajes()

func actualizarTurno(jugador: bool):
	if jugador:$Label.text= "TURNO: JUGADOR"
	else:$Label.text= "TURNO: ENEMIGO"
