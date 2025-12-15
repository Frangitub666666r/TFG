extends CharacterBody2D
class_name Personaje

@export var Data : PersonajeData 

const VELOCIDAD = 300.0

func _ready() -> void:
	if Data and Data.jugador == false:
		Controlador.connect("selecEnemigo",mostrar_seleccion)
		Controlador.connect("ataqueIniciado", ocultarSeleccion)


func _on_panel_gui_input(event):

	if Data.jugador:
		if Input.is_action_just_pressed("click_izquierdo") and Controlador.menuAbierto and Controlador.menuAbierto:
			$acciones.abrirMenu()
	else:
		if Input.is_action_just_pressed("click_izquierdo") and $seleccionar.visible:
			Controlador.establecerEnemigo(self)
			Controlador.iniciarAtaque()

func mostrar_seleccion():
	$seleccionar.visible = true
	
func ocultarSeleccion():
		$seleccionar.visible = false
