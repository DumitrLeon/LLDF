extends State
class_name Idle

func Enter():
	anim.play("Idle")

func Update(_delta: float):
	if x_input() != 0:
		Transitioned.emit(self, "Walk")
	if check_jump():
		pass

func _physics_process(delta: float) -> void:
	pass
