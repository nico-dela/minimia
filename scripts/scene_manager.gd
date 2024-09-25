extends Node2D

var current_scene

func _ready():
	load_scene("res://scenes/room_1.tscn")

func load_scene(path):
	if current_scene:
		call_deferred("remove_and_free_scene")
	
	# Asegúrate de diferir la carga de la nueva escena
	call_deferred("_load_new_scene", path)

func _load_new_scene(path):
	var new_scene = load(path)
	if new_scene is PackedScene:
		var instance = new_scene.instantiate()
		add_child(instance)
		instance.name = "CurrentScene"
		current_scene = instance
	else:
		print("Error: Failed to load scene")

func remove_and_free_scene():
	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()
		current_scene = null

# Método para mostrar el menú de pausa
func show_pause_menu():
	$PauseMenu.visible = true
	get_tree().paused = true

# Método para ocultar el menú de pausa
func hide_pause_menu():
	$PauseMenu.visible = false
	get_tree().paused = false
