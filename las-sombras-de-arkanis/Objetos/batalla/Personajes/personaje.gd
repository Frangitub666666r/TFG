extends CharacterBody2D

@export var Data : PersonajeData

const VELOCIDAD = 300.0

func _on_panel_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click_izquierdo"):
		$Acciones.abrirMenu()
