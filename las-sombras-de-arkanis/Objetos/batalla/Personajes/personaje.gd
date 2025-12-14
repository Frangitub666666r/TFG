extends CharacterBody2D
class_name Personaje

@export var Data : PersonajeData 

const VELOCIDAD = 300.0

func _ready() -> void:
	if Data and Data.jugador == false:
		
		Controlador.selecEnemigo.connect(mostrar_seleccion)

func _on_panel_gui_input(event: InputEvent):

	if Data.jugador:
		if Input.is_action_just_pressed("click_izquierdo" , mostrar_seleccion()) and Controlador.abrirMenu and Controlador.turnoJugador:
			$acciones.abrirMenu()
	else:
		if $seleccionar.visible:
			Controlador.establecerEnemigo(self)

func mostrar_seleccion():
	$seleccionar.visible = true
