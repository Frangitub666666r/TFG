extends Node
signal saludCero()
signal daño_recibido()

@export var SaludBar : ProgressBar
var saludMAX: float
var saludACTUAL: float

var armadura: float=1
var sinSalud: bool= false

func recibirDaño(cantidad : float, prob: float, aum: float):
	if sinSalud:
		return
	saludACTUAL-=cantidad
	#calcularDaño(cantidad, prob, aum)
	print("daño recibido: ", cantidad)
	emit_signal("daño_recibido")
	
	actualizarProgessBAR()
	if (saludACTUAL<=0):
		emit_signal("saludCero")
		sinSalud=true
	else:
		emit_signal("daño_recibido")


#No funciona aún:
#func calcularDaño(cantidad: float, prob: float, aum: float)-> float:
#	var resultado : float = cantidad
	#calcular daño
#	if(randf_range(0,1))>=prob:
#		resultado *=aum
		
		
		#calcular la armadura
#	resultado /=armadura
#	return resultado
func actualizarProgessBAR ():
	if SaludBar:
		SaludBar.value = saludACTUAL/saludMAX
