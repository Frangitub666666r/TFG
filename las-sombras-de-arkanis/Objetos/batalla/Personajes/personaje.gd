extends CharacterBody2D
class_name Personaje
signal salud_cambiada(nueva_salud: float)
@export var Data : PersonajeData 
@onready var componente_salud: Node = $ComponenteSalud



@onready var animacion: AnimatedSprite2D = $animacion
var personaje_Objetivo
var atacando: bool= false
const VELOCIDAD = 700.0

var posInicial : Vector2
var regresarInicio : bool = false 



func _ready() -> void:
	posInicial = global_position
	

	animacion.play("idle")
	
	componente_salud.saludACTUAL = Data.salud
	componente_salud.saludMAX = Data.salud
	componente_salud.actualizarProgessBAR()
	if  Data.jugador == false:
		add_to_group("Enemigo")
		Controlador.connect("selecEnemigo",mostrar_seleccion)
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
	
	# Verificamos si tenemos un objetivo y no estamos atacando (en rango)
	if personaje_Objetivo and atacando == false:
		var distancia = global_position.distance_to(personaje_Objetivo.global_position)
		
		if distancia > 300.0:
			# Lógica de Persecución
			animacion.play("Salt")
			if distancia > 500.0:
				animacion.play("AtaK") # ¿Debería ser 'run' o similar? 'AtaK' podría ser confuso aquí.
				
			var direccion: Vector2 = (personaje_Objetivo.global_position - global_position).normalized()
			velocity = VELOCIDAD * direccion
			move_and_slide()
			
		else:
			# En Rango de Ataque
			atacando = true
			animacion.play("impact")
			
	# --- Lógica de Regreso al Inicio (Horizontal Exclusivo) ---
	
	elif regresarInicio:
		var margin = 2.0 # Margen de detención en píxeles
		
		# 1. Calcular la diferencia solo en X
		var dx = posInicial.x - global_position.x
		
		# Verificamos si la distancia horizontal es mayor que el margen
		if abs(dx) > margin:
			
			# Calculamos la dirección (puede ser -1 o 1)
			var direccion_x = sign(dx)
			
			# Creamos el vector de velocidad solo en X
			velocity = Vector2(direccion_x * VELOCIDAD, 0)
			
			move_and_slide()
			animacion.play("AtaK")
		else:
			# Si estamos dentro del margen, terminamos el regreso
			global_position.x = posInicial.x # Forzamos la posición X exacta
			velocity = Vector2.ZERO
			regresarInicio = false
			animacion.play("idle")
			
	else:
		# Si no hay objetivo ni hay que regresar, aseguramos que la velocidad sea cero
		velocity = Vector2.ZERO
		move_and_slide() # Necesario para aplicar velocity=0
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



func _on_titus_animation_looped() -> void:
	if animacion.animation == "impact":
		print("Hacer daño al personaje")
		
		personaje_Objetivo.componente_salud.recibirDaño(Data.daño)
		
		personaje_Objetivo = null
		atacando= false
		regresarInicio= true
		Controlador.cambiarTurno()
		Controlador.menuAbierto=true
