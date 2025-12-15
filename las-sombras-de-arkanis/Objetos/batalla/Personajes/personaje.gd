extends CharacterBody2D
class_name Personaje
signal salud_cambiada(nueva_salud: float)
@export var Data : PersonajeData 

@onready var animacion: AnimatedSprite2D = $titus
var personaje_Objetivo
var atacando: bool= false
const VELOCIDAD = 700.0
var posInicial : Vector2
var regresarInicio : bool = false 

func _ready() -> void:
	posInicial = global_position
	if Data.jugador == true:
		animacion.play("idle")
	if Data and Data.jugador == false:
		Controlador.connect("selecEnemigo",mostrar_seleccion)
		Controlador.connect("ataqueIniciado", ocultarSeleccion)


func _on_panel_gui_input(event):
	if Data.jugador:
		if Input.is_action_just_pressed("click_izquierdo") and Controlador.menuAbierto and Controlador.turnoJugador:
			$acciones.abrirMenu()
			Controlador.establecerPersonaje(self)
	else:
		if Input.is_action_just_pressed("click_izquierdo") and $seleccionar.visible:
			Controlador.establecerEnemigo(self)
			Controlador.iniciarAtaque()

func _physics_process(delta: float) -> void:
	if personaje_Objetivo and atacando==false:
		var distancia = global_position.distance_to(personaje_Objetivo.global_position)
		if distancia > 300.0:
			animacion.play("Salt")
			if distancia >500.0:
				animacion.play("AtaK")
			var direccion= (personaje_Objetivo.global_position-global_position).normalized()
			velocity= VELOCIDAD * direccion
			move_and_slide()
			
			
		else:
			atacando=true
			animacion.play("impact")
			
			
	if regresarInicio:
		var distance = posInicial.distance_to(global_position)
		if distance>0:
			var posicion = posInicial - global_position
			velocity= VELOCIDAD * posicion
			move_and_slide()
			animacion.play("AtaK")
		else:
			regresarInicio = false
			animacion.play("idle")
func atacarPersonaje(target):
	personaje_Objetivo=target
	

func mostrar_seleccion():
	$seleccionar.visible = true
	
func ocultarSeleccion():
	$seleccionar.visible = false


func recibir_daño(cantidad: float):
	if Data:
		Data.salud -= cantidad
		Data.salud = max(0, Data.salud) 
		salud_cambiada.emit(Data.salud)


func _on_titus_animation_finished() -> void:
	if animacion.animation == "impact":
		print("Hacer daño al personaje")
		personaje_Objetivo = null
		atacando= false
		regresarInicio= false
