extends CharacterBody2D

@export var Data : PersonajeData
@onready var animaciones: AnimationPlayer = $CollisionShape2D/titus/animaciones

const VELOCIDAD = 300.0

func _ready() :
	animaciones.play("Stare")
