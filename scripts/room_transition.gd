extends Area2D

@export var target_scene: String  # Ruta de la escena a la que se cambiará

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		var world_node = get_tree().root.get_node("SceneManager")
		if world_node:
			world_node.load_scene(target_scene)
		else:
			print("Error: Could not find the SceneManager node")
