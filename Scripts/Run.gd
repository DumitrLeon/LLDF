extends Movement
class_name Run


func Enter():
	anim.play("Run")


func Update(_delta: float):
	check_jump()
	super.Update(_delta)
	if player.dir == 0:
		Transitioned.emit(self, "Idle")
	if Input.is_action_just_released("sprint"):
		Transitioned.emit(self, "Walk")

func Physics_process(delta: float) -> void:
	if not check_floor():
		Transitioned.emit(self, "Idle_air")
