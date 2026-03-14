extends Movement
class_name Idle


func Enter():
	anim.play("Idle")


func Update(_delta: float):
	check_slide()
	check_jump()
	
	#GODMODE
	if Input.is_action_just_pressed("GodMode"):
		Transitioned.emit(self, "GodMode")
	
	if player.dir != 0:
		Transitioned.emit(self, "Walk")
	
	if player.velocity.x != 0:
		player.velocity.x = move_toward(player.velocity.x, 0.0, player.friction * _delta)


func Physics_process(delta: float) -> void:
	if not check_floor():
		player.cojote_jump.start()
		Transitioned.emit(self, "Idle_air")
