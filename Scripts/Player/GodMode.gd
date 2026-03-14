extends Movement
class_name GodMode

func Enter():
	player.set_collision_layer_value(1, false)
	player.set_collision_mask_value(1, false)

func Update(_delta: float):
	if Input.is_action_just_pressed("GodMode"):
		player.set_collision_layer_value(1, true)
		player.set_collision_mask_value(1, true)
		Transitioned.emit(self, "Idle")

func Physics_process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		player.velocity.y = -200
	elif Input.is_action_pressed("down"):
		player.velocity.y = 200
	elif Input.is_action_pressed("left"):
		player.velocity.x = -200
	elif Input.is_action_pressed("right"):
		player.velocity.x = 200
	else:
		player.velocity = Vector2.ZERO
