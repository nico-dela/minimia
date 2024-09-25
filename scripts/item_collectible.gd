extends Area2D

# Variable para definir qué ítem se está recogiendo (puedes personalizar los datos del ítem)
@export var item_data = {
	"name": "Coleccionable",
	"icon": preload("res://images/coleccionables/Free-Item_32x32px/ovenmitts.png"),  # Cambia el path según el icono de tu ítem
}

func _ready():
	# Configurar la detección de colisiones para detectar al jugador
	connect("body_entered", Callable(self, "_on_body_entered"))

# Método que se ejecuta cuando algo entra en contacto con el ítem (como el jugador)
func _on_body_entered(body):
	if body.name == "Player":  # Asegúrate de que el nodo del jugador se llame "Player"
		# Llamar al método del jugador para agregar el ítem al inventario
		body.add_item_to_inventory(item_data)
		# Eliminar el ítem de la escena después de recogerlo
		queue_free()
