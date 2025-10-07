extends Movement
class_name Walk


func Enter():
	anim.play("Walk")


func Update(_delta: float):
	check_jump()
	super.Update(_delta)
	if player.dir == 0:
		Transitioned.emit(self, "Idle")
	if Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Run")


func Physics_process(delta: float) -> void:
	if not check_floor():
		Transitioned.emit(self, "Idle_air")
	
