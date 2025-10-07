extends Movement
class_name Idle_air


func Enter():
	anim.play("Idle_air")


func Update(_delta: float):
	super.Update(_delta)


func Physics_process(delta: float) -> void:
	apply_gravity()
	if check_floor():
		Transitioned.emit(self, "Idle")
