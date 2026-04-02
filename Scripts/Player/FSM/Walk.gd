extends Movement
class_name Walk


func Enter():
	anim.play("Walk")


func Update(_delta: float):
	check_slide(player)
	check_jump(player)
	super.Update(_delta)
	if player.dir == 0:
		Transitioned.emit(self, "Idle")
	if Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Run")


func Physics_process(delta: float) -> void:
	if not check_floor(player):
		player.cojote_jump.start()
		Transitioned.emit(self, "Idle_air")
	
