extends Movement
class_name Idle


func Enter():
	anim.play("Idle")


func Update(_delta: float):
	check_jump()
	if player.dir != 0:
		Transitioned.emit(self, "Walk")


func Physics_process(delta: float) -> void:
	if not check_floor() and not StateMachine.current_state.name == "Jump":
		Transitioned.emit(self, "Idle_air")
