extends Movement
class_name Idle_air


func Enter():
	anim.play("Idle_air")

func Update(_delta: float):
	if player.cojote_jump.time_left == 0:
		if player.jumps_made == 0:
			player.jumps_made += 1
	
	check_jump(player)
	super.Update(_delta)


func Physics_process(delta: float) -> void:
	apply_gravity(player)
	if check_floor(player):
		Transitioned.emit(self, "Idle")
