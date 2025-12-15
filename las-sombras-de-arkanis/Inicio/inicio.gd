extends Node2D



func _on_salir_button_down() -> void:
	get_tree().quit()


func _on_button_button_down() -> void:

		get_tree().change_scene_to_file("res://Objetos/batalla/batalla.tscn")
