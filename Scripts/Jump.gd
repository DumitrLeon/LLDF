extends Movement
class_name Jump

func Enter():
	player.velocity.y = player.jump_boost


func Update(_delta: float):
	super.Update(_delta)
	player.slide_timer.start(0.0)
	player.slide_timer.stop()
	if player.velocity.y > -30:
		Transitioned.emit(self, "Idle_air")
	
	if Input.is_action_just_released("jump"):
		player.velocity.y = move_toward(player.velocity.y, 0.0, 200)


func Physics_process(delta: float) -> void:
	apply_gravity()
	if check_floor():
		Transitioned.emit(self, "idle")
	if player.dir == 0:
		anim.play("Jump_up")
		anim.stop()
		anim.frame = 2
	else:
		anim.play("Jump_side")
		anim.stop()
		anim.frame = 2
