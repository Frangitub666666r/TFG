extends Control


func _ready() -> void:
	cerrarMenu()


func abrirMenu():
	for p in get_tree().get_nodes_in_group("Jugador"):
		p.get_node("acciones").cerrarMenu()
	visible=true

func cerrarMenu():
	visible=false


func _on_huir_button_down() -> void:
	cerrarMenu()
	print("Huyendo....")

func _on_habilidades_button_down() -> void:
	cerrarMenu()
	print("Seleccione habilidad....")


func _on_defender_button_down() -> void:
	cerrarMenu()
	Controlador.defenderPersonaje()
	print("Defendiendo....")


func _on_atacar_button_down() -> void:
	cerrarMenu()
	Controlador.empezarAtaque()
	print("Atacando....")
