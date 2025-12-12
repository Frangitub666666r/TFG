extends Control


func _ready() -> void:
	cerrarMenu()
func abrirMenu():
	visible=true

func cerrarMenu():
	visible=false


func _on_huir_button_down() -> void:
	cerrarMenu()
	print("Huyendo....")

func _on_habilidades_button_down() -> void:
	cerrarMenu()


func _on_defender_button_down() -> void:
	cerrarMenu()


func _on_atacar_button_down() -> void:
	cerrarMenu()
