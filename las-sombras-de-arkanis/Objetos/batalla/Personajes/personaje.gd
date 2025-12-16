extends CharacterBody2D
class_name Personaje
signal salud_cambiada(nueva_salud: float)
@export var Data : PersonajeData 
@onready var componente_salud: Node = $ComponenteSalud

@onready var animacion: AnimatedSprite2D = $animacion
var personaje_Objetivo
var atacando: bool = false
const VELOCIDAD = 700.0

var posInicial : Vector2
var regresarInicio : bool = false 


func _ready() -> void:
	posInicial = global_position  # ✅ Correcto: el jugador siempre parte de aquí
	animacion.play("idle")
	
	componente_salud.saludACTUAL = Data.salud
	componente_salud.saludMAX = Data.salud
	componente_salud.actualizarProgessBAR()
	if Data.jugador == false:
		add_to_group("Enemigo")
		Controlador.connect("selecEnemigo", mostrar_seleccion)
		Controlador.connect("ataqueIniciado", ocultarSeleccion)
	else:
		add_to_group("Jugador")


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
	# --- Lógica de Ataque y Persecución ---
	if personaje_Objetivo and atacando == false:
		var distancia = global_position.distance_to(personaje_Objetivo.global_position)
		
		if distancia > 300.0:
			# Lógica de Persecución
			animacion.play("Salt")
			if distancia > 500.0:
				animacion.play("AtaK")
				
			var direccion: Vector2 = (personaje_Objetivo.global_position - global_position).normalized()
			velocity = VELOCIDAD * direccion
			move_and_slide()
			
		else:
			# En Rango de Ataque
			atacando = true
			animacion.play("impact")
			
	# --- Lógica de Regreso al Inicio (para jugador Y enemigos) ---
	elif regresarInicio:
		var margin = 2.0
		var distancia_total = global_position.distance_to(posInicial)
		
		if distancia_total > margin:
			var direccion: Vector2 = (posInicial - global_position).normalized()
			velocity = VELOCIDAD * direccion
			move_and_slide()
			animacion.play("AtaK")
		else:
			# Regresar EXACTAMENTE a la posición de inicio del turno
			global_position = posInicial
			velocity = Vector2.ZERO
			regresarInicio = false
			animacion.play("idle")
			Controlador.cambiarTurno()
			Controlador.menuAbierto = true
			
	else:
		velocity = Vector2.ZERO
		move_and_slide()


func atacarPersonaje(target):
	personaje_Objetivo = target


func mostrar_seleccion():
	$seleccionar.visible = true
	
func ocultarSeleccion():
	$seleccionar.visible = false


func recibir_daño(cantidad: float):
	if Data:
		Data.salud -= cantidad
		Data.salud = max(0, Data.salud) 
		salud_cambiada.emit(Data.salud)



func _on_animacion_animation_looped() -> void:
	if animacion.animation == "impact":
		print("Hacer daño al personaje")
		
		personaje_Objetivo.componente_salud.recibirDaño(Data.daño)
		
		personaje_Objetivo = null
		atacando = false
		regresarInicio = true
