extends CanvasLayer

# Referencias a los nodos de la interfaz
@onready var barra_vida: TextureProgressBar = $MarginContainer/VBoxContainer/Barra_Vida

# Referencia al personaje del que obtendremos los datos
# Debes asignarla en _ready o cuando el personaje aparezca.
var jugador_personaje: Personaje = null

func _ready():
	# Asume que ya tienes una manera de obtener la instancia del personaje.
	# Por ejemplo, si el personaje es el primer hijo de la escena principal:
	# jugador_personaje = get_tree().root.get_child(0).get_node("NombreDeTuPersonaje")
	pass # Asigna el personaje aquí o llama a la función set_personaje() más tarde

# Función para establecer y conectar al personaje
func set_personaje(personaje: Personaje):
	jugador_personaje = personaje
	if jugador_personaje:
	  
	 
		
		# Conecta la barra de vida a los valores máximos de salud del recurso
		barra_vida.max_value = jugador_personaje.Data.salud # Usa la salud inicial como max_value
		barra_vida.value = jugador_personaje.Data.salud
		
		# Conectamos una señal del personaje (que debes crear)
		# para que el HUD sepa cuándo actualizarse.
		# jugador_personaje.salud_cambiada.connect(actualizar_vida) # Descomentar cuando crees la señal


func actualizar_vida(nueva_salud: float):
	barra_vida.value = nueva_salud
	# También puedes mostrar el valor numérico
	# label_vida_valor.text = str(nueva_salud) + " / " + str(barra_vida.max_value)
