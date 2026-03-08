extends Movement
class_name Run


func Enter():
	anim.play("Run")


func Update(_delta: float):
	check_slide()
	check_jump()
	super.Update(_delta)
	if (player.dir == 0) and (not abs(player.velocity.x) > 0.1):
		Transitioned.emit(self, "Idle") 
	if (not Input.is_action_pressed("sprint")) and (not abs(player.velocity.x) > player.walking_speed):
		Transitioned.emit(self, "Walk")
	if (Input.is_action_pressed("sprint")) and (player.dir == 0) and (not abs(player.velocity.x) > player.walking_speed):
		Transitioned.emit(self,"Walk")

func Physics_process(delta: float) -> void:
	if not check_floor():
		player.cojote_jump.start()
		Transitioned.emit(self, "Idle_air")
