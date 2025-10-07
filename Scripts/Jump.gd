extends Movement
class_name Jump

var frame_progress = 0

func Enter():
	player.velocity.y = player.jump_boost


func Update(_delta: float):
	super.Update(_delta)
	if player.velocity.y > -30:
		Transitioned.emit(self, "Idle_air")


func Physics_process(delta: float) -> void:
	apply_gravity()
	if check_floor():
		Transitioned.emit(self, "idle")
	
	frame_progress = anim.frame_progress
	if abs(player.velocity.x) < 0.1:
		anim.play("Jump_up")
	else:
		anim.play("Jump_side")
	anim.frame_progress = frame_progress
