extends Control

func _on_Iniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/scene_manager.tscn")

func _on_Configuracion_pressed():
	var config_scene = preload("res://scenes/configuration.tscn").instantiate()
	add_child(config_scene)

func _on_Creditos_pressed():
	var credits_scene = preload("res://scenes/credits.tscn").instantiate()
	add_child(credits_scene)

func _on_Salir_pressed():
	get_tree().quit()
