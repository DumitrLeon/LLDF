extends Movement
class_name Jump

func Enter():
	player.velocity.y = player.jump_boost
	if abs(player.velocity.x) < 0.1:
		anim.play("Jump_up")
	else:
		anim.play("Jump_side")
	
	


func Update(_delta: float):
	super.Update(_delta)
	if player.velocity.y > -30:
		Transitioned.emit(self, "Idle_air")


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
