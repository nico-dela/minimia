extends CharacterBody2D

const SPEED = 100.0

@onready var animated_sprite = $AnimatedSprite2D
var target_position = Vector2()
var moving = false

func _ready():
	animated_sprite.play("idle")
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		target_position = get_global_mouse_position()
		moving = true

func _physics_process(_delta):
	if moving:
		move_towards_target()
	else:
		handle_movement()

func move_towards_target():
	var direction = (target_position - global_position).normalized()
	var velocity_vector = direction * SPEED

	if global_position.distance_to(target_position) > 2:
		velocity = velocity_vector
		animated_sprite.flip_h = velocity.x < 0
		animated_sprite.play("walk")
	else:
		moving = false
		velocity = Vector2.ZERO
		animated_sprite.play("idle")

	var collision = move_and_collide(velocity * get_physics_process_delta_time())
	if collision:
		moving = false
		velocity = Vector2.ZERO
		animated_sprite.play("idle")

func handle_movement():
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")

	var velocity_vector = Vector2(direction_x, direction_y).normalized() * SPEED

	if velocity_vector != Vector2.ZERO:
		velocity = velocity_vector
		animated_sprite.flip_h = velocity.x < 0
		animated_sprite.play("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		animated_sprite.play("idle")

	move_and_slide()

# Método para agregar ítems al inventario
func add_item_to_inventory(item_data):
	# Obtener el inventario desde el scene_manager
	var scene_manager = get_parent()  # Asume que el jugador es hijo directo de scene_manager
	var inventory = scene_manager.get_node("Inventory")  # Ajusta si es necesario

	if inventory:
		inventory.add_item(item_data)  # Llama al método del inventario para agregar el ítem
		print("Ítem agregado al inventario: ", item_data["name"])
	else:
		print("Error: No se pudo agregar el ítem al inventario")
