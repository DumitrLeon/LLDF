extends Movement
class_name Jump

func Enter():
	player.velocity.y = player.jump_boost


func Update(_delta: float):
	super.Update(_delta)
	if player.velocity.y > -60:
		Transitioned.emit(self, "Idle_air")
	
	if not Input.is_action_pressed("jump"):
		player.velocity.y = move_toward(player.velocity.y, 0.0, 200)


func Physics_process(delta: float) -> void:
	apply_gravity()
	if check_floor():
		Transitioned.emit(self, "idle")
	if player.dir == 0:
		anim.play("Jump_up")
	else:
		anim.play("Jump_side")
