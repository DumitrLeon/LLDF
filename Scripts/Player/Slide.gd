extends State
class_name Slide

var timer = 0.0
var slide_power = 200
var direction = false

func Enter():
	collision_player.position.y = 11.25
	collision_player.shape.size = Vector2(22.0, 9.0)
	timer = 0.0
	if player.dir == 0:
		direction = (true if player_sprite.scale.x > 0 else false)
	else:
		direction = (true if player.dir == 1 else false)
	anim.play("Slide")
	
	player.velocity.x = slide_power * (1 if direction else -1)

func Exit():
	collision_player.position.y = 0.25
	collision_player.shape.size = Vector2(6.0, 30.0)

func Update(_delta: float):
	player.velocity.x = move_toward(player.velocity.x, 150.0 * (1 if direction else -1), 1)
	
	if RayCasts[0].is_colliding():
		print("Sto collidendo con qualcosa!")
	
	if (Input.is_action_just_pressed("jump")) and (not RayCasts[0].is_colliding()):
		player.velocity.x += (-170 if player.velocity.x < 0 else 170)
		Transitioned.emit(self, "jump")

func Physics_process(delta: float) -> void:
	timer += delta
	if (timer > 0.5) and ( not RayCasts[0].is_colliding()):
		Transitioned.emit(self, "Idle")
	
	if not player.is_on_floor():
		Transitioned.emit(self, "Idle_Air")
