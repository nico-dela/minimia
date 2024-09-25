extends Control

var inventory_items = []

func _ready():
	update_inventory()

func add_item(item):
	inventory_items.append(item)
	update_inventory()

func update_inventory():
	# Limpia el HBoxContainer antes de actualizar
	for child in $HBoxContainer.get_children():
		child.queue_free()  # Elimina los hijos existentes

	# Agrega los nuevos ítems al HBoxContainer
	for item in inventory_items:
		var button = TextureButton.new()
		button.texture_normal = item.icon
		button.connect("pressed", Callable(self, "_on_item_pressed").bind(item))
		$HBoxContainer.add_child(button)

func _on_item_pressed(item):
	print("Seleccionaste el ítem: ", item.name)
