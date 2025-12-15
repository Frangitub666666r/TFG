extends Node
signal saludCero()

@export var SaludBar : ProgressBar
var saludMAX: float
var saludACTUAL: float



func recibirDaño(cantidad : float):
	saludACTUAL-=cantidad
	print("daño recibido: ", cantidad)
	actualizarProgessBAR()
	if (saludACTUAL<=0):
		emit_signal("saludCero")


func actualizarProgessBAR ():
	if SaludBar:
		SaludBar.value = saludACTUAL/saludMAX
